require 'date'

class Confreaks
  # Attribute reader
  attr_reader :year

  # Include HTTParty
  include HTTParty

  base_uri 'confreaks.tv/api'

  # Create constructor for Confreaks object
  #
  # year  - The string of year
  #
  # Examples
  #
  #   Confreaks.new('2015')
  #
  # Returns nothing
  def initialize(year)
    @year = year
  end

  # List events of year
  #
  # Examples
  #
  #   conf = Confreaks.new('2015')
  #   conf.events_of_year
  #
  # Returns Array of events
  def events_of_year(field = nil)
    results = field ? events.select!{ |event| event['short_code'].downcase.include? field } : events

    parse_events(results)
  end

  private

    # Private: Create table of events
    #
    # events: List of events
    #
    # Examples
    #
    #   parse_events
    #
    # Returns Terminal Table object
    def parse_events(events)
      event_rows = []
      unless events.nil? || events.empty?
        events.each do |event|
          event_rows << [event['display_name'], "http://confreaks.tv/events/#{event['short_code']}", event_date(event['start_at']), event_date(event['end_at'])] if event_of_year?(event['short_code'])
        end
        Terminal::Table.new headings: ['Event', 'Link', 'Start date', 'End date'], rows: event_rows
      else
        nil
      end
    end

    # Private: List of events
    #
    # Examples
    #
    #   events
    #
    # Returns the JSON list of events
    def events
      response = self.class.get('/v1/events.json')
      response.code == 200 ? JSON.parse(response.body) : nil
    end

    # Private: Check event belongs year
    #
    # event  - The event name
    #
    # Examples
    #
    #   event_of_year?('Hello world 2015')
    #
    # Returns Boolean
    def event_of_year?(event)
      event.include? year
    end

    # Private: Converts string to date
    #
    # date  - The string date
    #
    # Examples
    #
    #   event_date("2015-09-25T00:00:00.000Z")
    #   # => "2015-09-25"
    #
    # Return Date
    def event_date(date)
      DateTime.parse(date).to_date.to_s
    end
end

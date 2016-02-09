require 'httparty'

class StackOverFlow
  # Attribute reader
  attr_reader :options

  # Include HTTParty
  include HTTParty

  # Page size
  PAGE_SIZE = 10

  base_uri 'api.stackexchange.com'

  # Create constructor for StackOverFlow object.
  #
  # keywords  - The keywords will match all questions.
  # accepted  - True for questions with accepted answers - False only those without.
  #
  # Examples
  #
  #   StackOverFlow.new('Ruby on Rails')
  #
  # Returns nothing
  def initialize(keywords, accepted)
    @options = { query: { pagesize: PAGE_SIZE, q: keywords, accepted: accepted, site: 'stackoverflow' } }
  end

  # List of ten questions based on attributes.
  #
  # Examples
  #
  #   stackoverflow = StackOverFlow.new('activerecord nomethod error', true)
  #   stackoverflow.questions
  #   # =>
  #     [
  #       {
  #         'tags': ['ruby-on-rails', 'ruby'],
  #         'owner': { 'display_name': 'johndoe', 'link': 'http://stackoverflow.com/users/2398/johndoe'},
  #         'answer_count': 14,
  #         'accepted_answer_link': 'http://stackoverflow.com/a/21420719/',
  #         'title': 'PG::ConnectionBad - could not connect to server: Connection refused',
  #         'link': 'http://stackoverflow.com/questions/19828385/pgconnectionbad-could-not-connect-to-server-connection-refused'
  #       },
  #       {
  #         ....
  #       },
  #     ]
  #
  # Returns the JSON list of questions
  def questions
    parse_questions
  end

  private

    # Private: List of raw question
    #
    # options  - The query options
    #
    # Examples
    #
    #   raw_questions(options)
    #
    # Returns the JSON list of raw questions
    def raw_questions(options)
      response = self.class.get('/2.2/search/advanced', options)
      response.code == 200 ? JSON.parse(response.body)['items'] : nil
    end

    # Private: Parse list of raw questions
    #
    # Examples
    #
    #   parse_questions(raw_questions(options))
    #
    # Returns list of questions
    def parse_questions
      questions = []
      raws = raw_questions(options)
      unless raws.nil? || raws.empty?
        raws.each do |q|
          owner = q['owner']
          questions << {
            tags: q['tags'],
            owner: { display_name: owner['display_name'], link: owner['link'] },
            answer_count: q['answer_count'],
            accepted_answer_link: "http://stackoverflow.com/a/#{q['accepted_answer_id']}",
            title: q['title'],
            link: q['link']
          }
        end
        questions
      else
        nil
      end
    end
end

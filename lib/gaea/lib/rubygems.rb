class RubyGems
  # Attribute reader
  attr_reader :option

  # Include HTTParty
  include HTTParty

  base_uri 'rubygems.org/api/'

  # Create constructor for RubyGems object
  #
  # query  - The query
  #
  # Examples
  #
  #   RubyGems.new('weather')
  #
  # Returns nothing
  def initialize(query)
    @option = { query: { query: query } }
  end

  # List of gems match with query
  #
  # Examples
  #
  #   rgs = RubyGems.new('weather')
  #   rgs.gems
  #   # =>
  #     +------+-----------------------------------------------+----------------------------------+-------------+-----------+
  #     | Name | Info                                          | URL                              | Authors     | Downloads |
  #     +------+-----------------------------------------------+----------------------------------+-------------+-----------+
  #     | weer | Display the weather information of your city. | https://github.com/vinhnglx/weer | Vinh Nguyen | 134       |
  #     +------+-----------------------------------------------+----------------------------------+-------------+-----------+
  # Returns the table
  def gems
    # TODO: need to get more questions - Apply paginates
    parse_gems
  end

  private

    # Private: List of raw gems
    #
    # option  - The query option
    #
    # Examples
    #
    #   connect(option)
    #
    # Returns the JSON list of raw gems.
    def connect(option)
      response = self.class.get('/v1/search.json', option)
      response.code == 200 ? JSON.parse(response.body) : nil
    end

    # Private: Create table list of gems
    #
    # Examples
    #
    #   parse_gems
    #
    # Returns terminal table object
    def parse_gems
      gem_rows = []
      raws = connect(option)
      unless raws.nil? || raws.empty?
        raws.each do |g|
          gem_rows << [g['name'], g['info'][0..60], g['project_uri'], g['authors'], g['downloads']]
        end
        Terminal::Table.new headings: ['Name', 'Info', 'URL', 'Authors', 'Downloads'], rows: gem_rows
      else
        nil
      end
    end
end

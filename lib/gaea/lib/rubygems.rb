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
  #
  # Returns an Array of JSON of gems that match.
  def gems
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

    def parse_gems
      gems = []
      raws = connect(option)

      unless raws.nil? || raws.empty?
        raws.each do |g|
          gems << {
            name: g['name'],
            info: g['info'],
            url: g['project_uri'],
            authors: g['authors'],
            downloads: g['downloads']
          }
        end
        gems
      else
        nil
      end
    end
end

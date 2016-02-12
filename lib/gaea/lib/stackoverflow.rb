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
  #
  # Examples
  #
  #   StackOverFlow.new('Ruby on Rails')
  #
  # Returns nothing
  def initialize(keywords)
    @options = { query: { pagesize: PAGE_SIZE, q: keywords, accepted: true, site: 'stackoverflow' } }
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
    #   connect(options)
    #
    # Returns the JSON list of raw questions
    def connect(options)
      response = self.class.get('/2.2/search/advanced', options)
      response.code == 200 ? JSON.parse(response.body)['items'] : nil
    end

    # Private: Create table list of questions
    #
    # Examples
    #
    #   parse_questions
    #   # =>
    #     +---------------+-----------------------------------------------------------------------------------+-------------------------------------+-------------------------------------+
    #     | Owner         | Title                                                                             | Question                            | Accepted Answer                     |
    #     +---------------+-----------------------------------------------------------------------------------+-------------------------------------+-------------------------------------+
    #     | Daniel Cukier | Discover errors in Invalid Record factory girl                                    | http://stackoverflow.com/q/23374576 | http://stackoverflow.com/a/23374747 |
    #     | Chris Mendla  | Rails delete record fails                                                         | http://stackoverflow.com/q/35232445 | http://stackoverflow.com/a/35235143 |
    #     | Jorrin        | Manually assigning parent ID with has_many/belongs_to association in custom class | http://stackoverflow.com/q/35193155 | http://stackoverflow.com/a/35201406 |
    #     | simonmorley   | Rails i18n Attributes Not Working via JSON API                                    | http://stackoverflow.com/q/35113584 | http://stackoverflow.com/a/35117092 |
    #     | NeoP5         | Sonarqube 5.3: Error installing on Oracle 12 - columns missing                    | http://stackoverflow.com/q/34807593 | http://stackoverflow.com/a/35008747 |
    #     | kannet        | Invalid single-table inheritance type: dog is not a subclass of Pet               | http://stackoverflow.com/q/34988853 | http://stackoverflow.com/a/34989090 |
    #     | Brittany      | NoMethodError in Users#show error?                                                | http://stackoverflow.com/q/34980742 | http://stackoverflow.com/a/34980943 |
    #     | Mac           | Python POST binary data                                                           | http://stackoverflow.com/q/14365027 | http://stackoverflow.com/a/14448953 |
    #     | CuriousMind   | railstutorial.org, Chapter 6. unknown attribute: password                         | http://stackoverflow.com/q/12142374 | http://stackoverflow.com/a/12142417 |
    #     | Brittany      | Empty database, user already exists message?                                      | http://stackoverflow.com/q/34862365 | http://stackoverflow.com/a/34862683 |
    #     +---------------+-----------------------------------------------------------------------------------+-------------------------------------+-------------------------------------+
    #
    # Returns terminal table object
    def parse_questions
      question_rows = []
      raws = connect(options)
      unless raws.nil? || raws.empty?
        raws.each do |q|
          owner = q['owner']
          question_rows << [owner['display_name'], q['title'], "http://stackoverflow.com/q/#{q['question_id']}", "http://stackoverflow.com/a/#{q['accepted_answer_id']}"]
        end
        Terminal::Table.new headings: ['Owner', 'Title', 'Question', 'Accepted Answer'], rows: question_rows
      else
        nil
      end
    end
end

module Gaea
  module CLI
    class Looksfor < Thor
      # Search from multiple sources
      #
      # Options
      #
      #   keyword            - The keyword relate contents you wanna search
      #   source(require)    - One of 3 values: 'stackoverflow', 'gems', 'confreaks'
      #   year(optional)     - The year - will use with source confreaks
      #
      # Returns the results depend on source and keyword
      desc 'looksfor', 'Search from multiple sources'
      option :keyword, aliases: '-k', banner: 'The keyword relate to contents you wanna search'
      option :source, aliases: '-s', banner: 'The source - 3 default values: stackoverflow, gems and confreaks'
      option :year, aliases: '-y', banner: 'The year - only avalaible with source confreaks'
      def looksfor
        keyword = options[:keyword]

        results = case options[:source]
                  when 'stackoverflow'
                    raise OptionMissing, 'Oops, man, make sure you have the keyword option in your command' unless keyword
                    stack = StackOverFlow.new(keyword)
                    stack.questions
                  when 'gems'
                    raise OptionMissing, 'Oops, man, make sure you have the keyword option in your command' unless keyword
                    rgem = RubyGems.new(keyword)
                    rgem.gems
                  when 'confreaks'
                    year = options[:year]
                    raise OptionMissing, 'Oops, man, make sure you have the year option in your command' unless year
                    conf = Confreaks.new(year)
                    keyword ? conf.events_of_year(keyword) : conf.events_of_year
                  else
                    raise InvalidSource, 'Hey man, you wrong the source. Please check again!'
                  end
        puts Rainbow(results).bisque
      end
    end
  end
end

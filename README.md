# Gaea

[![Build Status](https://travis-ci.org/vinhnglx/gaea.svg?branch=develop)](https://travis-ci.org/vinhnglx/gaea)
[![Coverage Status](https://coveralls.io/repos/github/vinhnglx/gaea/badge.svg?branch=develop)](https://coveralls.io/github/vinhnglx/gaea?branch=develop)
[![Open Source Helpers](https://www.codetriage.com/vinhnglx/gaea/badges/users.svg)](https://www.codetriage.com/vinhnglx/gaea)

 The application helps you search information relate to languages and technologies. Currently, this application just supports three sources: [StackOverFlow](http://stackoverflow.com/) - [RubyGems](https://rubygems.org/) - [Confreaks](http://confreaks.tv/) with simple features.

I would like to develop this application become the powerful application like as *Gaea, a god in Greek mythology was the great mother of all.*

**Here is my todo-list:**

- Add more features for three sources, for example: paginates, search from tags, video, display more information for each result. I believe we will have more features when work with APIs of above sources.

- Extend to more sources: StackExchange or Google services such as [Server Fault](http://serverfault.com/), [Super User](http://superuser.com/), [Ask Ubuntu](http://askubuntu.com/), [Google Youtube API](https://developers.google.com/youtube/) ...

## Installation

```
$ gem install gaea
```

## Usage

```
Usage:
  gaea looksfor

Options:
  -k, [--keyword=The keyword relate to contents you wanna search]
  -s, [--source=The source - 3 default values: stackoverflow, gems and confreaks]
  -y, [--year=The year - only avalaible with source confreaks]

Search from multiple sources
```

### Search questions from StackOverFlow

```
gaea looksfor --keyword='activerecord' --source='stackoverflow'
```

![StackOverFlow](https://cloud.githubusercontent.com/assets/1997137/13025709/ac0291ca-d240-11e5-8c48-9c7a1c4ba179.png)

### Search gems from RubyGems

```
gaea looksfor --keyword='hanami' --source='gems'
```

![RubyGems](https://cloud.githubusercontent.com/assets/1997137/13025718/f66bfc74-d240-11e5-972f-7087ee420163.png)

### Search events from Confreaks

#### All events in year

```
gaea looksfor --year='2015' --source='confreaks'
```

![Confreaks](https://cloud.githubusercontent.com/assets/1997137/13025738/4d4d36a2-d241-11e5-9c91-5de2bd06fbe4.png)

#### All events relate to a language/technology in year

```
gaea looksfor --year='2015' --source='confreaks' --keyword='ruby'
```

![Confreaks](https://cloud.githubusercontent.com/assets/1997137/13025751/8f3ed200-d241-11e5-91a4-4e63604cc32c.png)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vinhnglx/gaea. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

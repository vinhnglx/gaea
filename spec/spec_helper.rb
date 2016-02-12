require 'webmock/rspec'
require 'coveralls'
require 'gaea'

WebMock.disable_net_connect!(allow_localhost: true)
Coveralls.wear!

Dir[__dir__ + '/support/**/*.rb'].each { |f| require f }

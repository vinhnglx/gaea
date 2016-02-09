require 'webmock/rspec'
require 'gaea'

WebMock.disable_net_connect!(allow_localhost: true)

Dir[__dir__ + '/support/**/*.rb'].each { |f| require f }

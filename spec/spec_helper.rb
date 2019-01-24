require 'bundler/setup'
require 'chefspec'
require 'chefspec/berkshelf'
require 'fauxhai'
require 'rspec/its'

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '7.5.1804'
end

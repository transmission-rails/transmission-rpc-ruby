require 'rubygems'
require 'webmock/rspec'

require File.join(File.dirname(__FILE__), '..', 'lib', 'transmission')
require File.join(File.dirname(__FILE__), 'helpers', 'stubs')

ENV['TESTING'] = 'true'

RSpec.configure do |config|

  config.include Stubs

end

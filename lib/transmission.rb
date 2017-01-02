require File.join(File.dirname(__FILE__), 'transmission', 'utils')
require File.join(File.dirname(__FILE__), 'transmission', 'rpc')
require File.join(File.dirname(__FILE__), 'transmission', 'config')

module Transmission
  VERSION = '1.0.0'.freeze

  RPC_VERSION = OpenStruct.new(MIN: 1, MAX: 15).freeze
end

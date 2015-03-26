require File.join(File.dirname(__FILE__), 'arguments', 'torrent_add')
require File.join(File.dirname(__FILE__), 'arguments', 'torrent_get')

module Transmission
  class Arguments
    class InvalidArgument < StandardError; end
  end
end
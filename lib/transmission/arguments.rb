require File.join(File.dirname(__FILE__), 'arguments', 'torrent_add')
require File.join(File.dirname(__FILE__), 'arguments', 'torrent_get')
require File.join(File.dirname(__FILE__), 'arguments', 'session_get')
require File.join(File.dirname(__FILE__), 'arguments', 'session_stats')

module Transmission
  class Arguments
    class InvalidArgument < StandardError; end
  end
end
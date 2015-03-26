require File.join(File.dirname(__FILE__), 'arguments', 'torrent_add')
require File.join(File.dirname(__FILE__), 'arguments', 'torrent_get')
require File.join(File.dirname(__FILE__), 'arguments', 'torrent_set')
require File.join(File.dirname(__FILE__), 'arguments', 'session_get')
require File.join(File.dirname(__FILE__), 'arguments', 'session_stats')

module Transmission
  class Arguments
    class InvalidArgument < StandardError; end

    attr_accessor :arguments

    def initialize(arguments = nil)
      @arguments = arguments.inject([]) do |attributes, attribute|
        raise Transmission::Arguments::InvalidArgument unless self.class::ATTRIBUTES.include? attribute
        attributes << attribute
      end if arguments
      @arguments = self.class::ATTRIBUTES if arguments.nil?
    end

    def to_arguments
      @arguments
    end

  end
end
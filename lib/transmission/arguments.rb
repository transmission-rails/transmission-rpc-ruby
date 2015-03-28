require File.join(File.dirname(__FILE__), 'arguments', 'torrent_add')
require File.join(File.dirname(__FILE__), 'arguments', 'torrent_set')
require File.join(File.dirname(__FILE__), 'arguments', 'session_set')

module Transmission
  class Arguments
    class InvalidArgument < StandardError; end

    attr_accessor :arguments

    def initialize(arguments = nil)
      @arguments = arguments.inject({}) do |attributes, (key, value)|
        found = self.class::ATTRIBUTES.select { |attr| attr[:field] == key.to_s }
        raise Transmission::Arguments::InvalidArgument, key if found.empty?
        attributes[key] = value
        attributes
      end if arguments
      @arguments = self.class::ATTRIBUTES if arguments.nil?
    end

    def to_arguments
      @arguments
    end

  end
end
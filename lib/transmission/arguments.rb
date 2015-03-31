require File.join(File.dirname(__FILE__), 'arguments', 'torrent_add')
require File.join(File.dirname(__FILE__), 'arguments', 'torrent_set')
require File.join(File.dirname(__FILE__), 'arguments', 'session_set')
require File.join(File.dirname(__FILE__), 'utils')

module Transmission
  class Arguments
    class InvalidArgument < StandardError; end

    attr_accessor :arguments

    ATTRIBUTES = []

    def initialize(arguments = nil)
      @arguments = arguments.inject({}) do |attributes, (key, value)|
        key = key.to_s
        found = self.class::ATTRIBUTES.select { |attr| attr[:field] == key }
        raise Transmission::Arguments::InvalidArgument, key if found.empty?
        attributes[key] = value
        attributes
      end if arguments
      @arguments = self.class::ATTRIBUTES if arguments.nil?
    end

    def to_arguments
      @arguments
    end

    class << self
      include Transmission::Utils

      def is_valid?(key)
        is_valid_key? key, self::ATTRIBUTES
      end

      def real_key(key)
        option_key key, self::ATTRIBUTES
      end

      def filter(arguments)
        arguments.inject({}) do |hash, (key, value)|
          found = self::ATTRIBUTES.select { |attr| attr[:field] == key.to_s }
          hash[key] = value unless found.empty?
          hash
        end
      end
    end

  end
end
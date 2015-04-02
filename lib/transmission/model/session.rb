module Transmission
  module Model
    class Session
      class SessionError < StandardError; end

      attr_accessor :attributes, :connector

      def initialize(session_object, connector)
        @attributes = session_object
        @connector = connector
      end

      def save!
        filtered = Transmission::Arguments::SessionSet.filter @attributes
        connector.set_session filtered
      end

      def to_json
        @attributes
      end

      def method_missing(symbol, *args)
        string = symbol.to_s
        if string[-1] == '='
          string = string[0..-2]
          key = Transmission::Arguments::SessionSet.real_key string
          return @attributes[key] = args.first if !!key
        else
          key = Transmission::Fields::SessionGet.real_key string
          return @attributes[key] if !!key
        end
        super
      end

      class << self
        def get(options = {})
          rpc = options[:connector] || connector
          body = rpc.get_session options[:fields]
          Session.new body, rpc
        end

        def connector
          Transmission::Config.get_connector
        end
      end
    end
  end
end
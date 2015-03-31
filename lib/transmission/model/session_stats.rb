module Transmission
  module Model
    class SessionStats

      attr_accessor :attributes, :connector

      def initialize(session_object, connector)
        @attributes = session_object
        @connector = connector
      end

      class << self
        def get(options = {})
          rpc = options[:connector] || connector
          body = rpc.get_session_stats options[:fields]
          SessionStats.new body, rpc
        end

        def connector
          Transmission::Config.get_connector
        end
      end
    end
  end
end
module Transmission
  module Model
    class Session
      class SessionError < StandardError; end

      attr_accessor :attributes

      def initialize(session_object)
        @attributes = session_object
      end

      def version
        @attributes['version'].split(' ').first
      end

      def rpc_version
        @attributes['rpc-version']
      end

      class << self
        def get(options = {})
          rpc = options[:connector] || connector
          session_body = rpc.get_session options
          session_stats_body = rpc.get_session_stats options
          merged_body = session_body.merge(session_stats_body)
          Session.new merged_body
        end

        def connector
          Transmission::Config.get_connector
        end
      end
    end
  end
end
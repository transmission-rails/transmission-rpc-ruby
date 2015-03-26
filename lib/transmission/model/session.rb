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
          session_response = (options[:connector] || connector).get_session options
          session_stats_response = (options[:connector] || connector).get_session_stats options
          session_body = JSON.parse session_response.body
          session_stats_body = JSON.parse session_stats_response.body
          raise SessionError unless session_response.status == 200 && session_body['result'] == 'success'
          raise SessionError unless session_stats_response.status == 200 && session_stats_body['result'] == 'success'
          merged_body = session_body['arguments'].merge(session_stats_body['arguments'])
          Session.new merged_body
        end

        def connector
          Transmission::Config.get_connector
        end
      end
    end
  end
end
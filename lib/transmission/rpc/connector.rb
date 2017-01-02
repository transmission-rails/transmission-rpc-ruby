require 'faraday'
require 'json'

module Transmission
  class RPC
    class Connector
      attr_reader :host, :port, :ssl, :credentials, :path, :session_id, :response, :rpc_version, :params

      def initialize(options = {})
        @host = options[:host] || 'localhost'
        @port = options[:port] || 9091
        @ssl  = !!options[:ssl]
        @credentials = options[:credentials] || nil
        @path = options[:path] || '/transmission/rpc'
        @session_id = options[:session_id] || ''
        @rpc_version = options[:rpc_version] || RPC_VERSION.MAX
      end

      def post(params = {})
        @params = params
        @response = perform_request
        @session_id = response.headers['x-transmission-session-id']

        validate_session        { |e| return post(params)  }
        validate_authentication { |e| StandardError.new(e) }
        validate_success        { |e| StandardError.new(e) }

        response_body
      end

      private

      def response_body
        JSON.parse(response.body) rescue {}
      end

      def rpc_response_message
        response_body['result']
      end

      def perform_request
        connection.post do |req|
          req.url(path)
          req.headers['X-Transmission-Session-Id'] = session_id
          req.headers['Content-Type'] = 'application/json'
          req.body = JSON.generate(params)
        end
      end

      def validate_authentication
        if response.status == 401
          yield('Failed basic authentication')
        end
      end

      def validate_success
        unless response.status == 200 && response_body['result'] == 'success'
          yield("Failed request with status #{response.status} and rpc response message #{rpc_response_message}")
        end
      end

      def validate_session
        if response.status == 409
          yield('Session expired')
        end
      end

      def connection
        @connection ||= begin
          connection = Faraday.new(url: "#{scheme}://#{host}:#{port}", ssl: { verify: true }) do |faraday|
            faraday.request :url_encoded
            faraday.adapter Faraday.default_adapter
          end
          connection.tap { |c| c.basic_auth(username, password) if credentials }
        end
      end

      def scheme
        ssl ? 'https' : 'http'
      end

      def username
        credentials[:username]
      end

      def password
        credentials[:password]
      end
    end
  end
end

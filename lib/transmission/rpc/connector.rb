require 'faraday'
require 'json'

module Transmission
  class RPC
    class Connector
      class AuthError < StandardError; end
      class ConnectionError < StandardError; end
      class InvalidSessionError < StandardError; end

      attr_accessor :host, :port, :ssl, :credentials, :path, :session_id, :response

      def initialize(options = {})
        @host = options[:host] || 'localhost'
        @port = options[:port] || 9091
        @ssl  = !!options[:ssl]
        @credentials = options[:credentials] || nil
        @path = options[:path] || '/transmission/rpc'
        @session_id = options[:session_id] || ''
      end

      def post(params = {})
        response = connection.post do |req|
          req.url @path
          req.headers['X-Transmission-Session-Id'] = @session_id
          req.headers['Content-Type'] = 'application/json'
          req.body = JSON.generate(params)
        end
        handle_response response
      end

      private

      def json_body(response)
        JSON.parse response.body
      rescue
        {}
      end

      def handle_response(response)
        @response = response
        if response.status == 409
          @session_id = response.headers['x-transmission-session-id']
          raise InvalidSessionError
        end
        body = json_body response
        raise AuthError if response.status == 401
        raise ConnectionError unless response.status == 200 && body['result'] == 'success'
        body['arguments']
      end

      def connection
        @connection ||= begin
          connection = Faraday.new(:url => "#{scheme}://#{@host}:#{@port}", :ssl => {:verify => false}) do |faraday|
            faraday.request  :url_encoded
            faraday.response :logger
            faraday.adapter  Faraday.default_adapter
          end
          connection.basic_auth(@credentials[:username], @credentials[:password]) if @credentials
          connection
        end
      end

      def scheme
        @ssl ? 'https' : 'http'
      end
    end
  end
end
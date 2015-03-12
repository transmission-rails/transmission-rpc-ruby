require 'faraday'
require 'json'

module Transmission
  class RPC
    class Connector
      class ConnectionSessionError < StandardError; end

      attr_accessor :host, :port, :ssl, :session_id, :auth_error

      def initialize(host = 'localhost', port = 9091, ssl = false, credentials = nil)
        @host, @port, @ssl, @credentials, @session_id = host, port, ssl, credentials, ''
      end

      def post(params = {})
        response = connection.post do |req|
          req.url '/transmission/rpc'
          req.headers['X-Transmission-Session-Id'] = @session_id
          req.headers['Content-Type'] = 'application/json'
          req.body = JSON.generate(params)
        end
        if response.status == 409
          @session_id = response.headers['x-transmission-session-id']
          return post(params) unless ENV['TESTING'] == 'true'
        elsif response.status == 401
          @auth_error = true
        end
        response
      end

      def connection
        scheme = @ssl ? 'https' : 'http'
        @connection ||= begin
          connection = Faraday.new(:url => "#{scheme}://#{@host}:#{@port}") do |faraday|
            faraday.request  :url_encoded
            faraday.response :logger
            faraday.adapter  Faraday.default_adapter
          end
          if @credentials
            connection.basic_auth(@credentials[:username], @credentials[:password])
          end
          connection
        end
      end
    end
  end
end
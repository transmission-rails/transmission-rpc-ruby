require 'faraday'
require 'json'

module Transmission
  class RPC
    class Connector
      class ConnectionSessionError < StandardError; end

      attr_accessor :host, :port, :ssl, :credentials, :path, :session_id, :auth_error

      def initialize(options = {})
        @host = options[:host] || 'localhost'
        @port = options[:port] || 9091
        @ssl  = options[:ssl]  || false
        @credentials = options[:credentials] || nil
        @path = options[:path] || '/transmission/rpc'
        @session_id = ''
      end

      def post(params = {})
        response = connection.post do |req|
          req.url @path
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

      private

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
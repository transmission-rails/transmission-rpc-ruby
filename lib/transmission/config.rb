module Transmission
  class Config
    class << self
      def set(options = {})
        @config = options
        @connector = Transmission::RPC.new(@config)
      end

      def get
        @config
      end

      def connector
        @connector
      end
    end
  end
end

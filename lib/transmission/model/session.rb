module Transmission
  module Model
    class Session

      attr_accessor :attributes

      def initialize(session_object)
        @attributes = session_object
      end



      class << self
        def get
          response = connector.get_session
        end
      end
    end
  end
end
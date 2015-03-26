module Transmission
  class Arguments
    class SessionStats

      ATTRIBUTES = [
          'activeTorrentCount',
          'downloadSpeed',
          'pausedTorrentCount',
          'torrentCount',
          'uploadSpeed',
          'cumulative-stats',
          'current-stats'
      ]

      attr_accessor :arguments

      def initialize(arguments = nil)
        @arguments = arguments.inject([]) do |attributes, attribute|
          raise Transmission::Arguments::InvalidArgument unless ATTRIBUTES.include? attribute
          attributes << attribute
        end if arguments
        @arguments = ATTRIBUTES if arguments.nil?
      end

      def to_arguments
        @arguments
      end

    end
  end
end
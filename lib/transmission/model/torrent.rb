module Transmission
  module Model
    class Torrent
      class TorrentError < StandardError; end
      class TorrentNotFoundError < StandardError; end
      class MissingAttributesError < StandardError; end
      class DuplicateTorrentError < StandardError; end

      attr_accessor :attributes, :deleted

      def initialize(torrent_object)
        @attributes = torrent_object
      end

      def delete!(remove_local_data = false)
        Torrent.connector.remove_torrent [self.attributes['id']], remove_local_data
        @deleted = true
      end

      def set

      end

      def move_up

      end

      def move_down

      end

      def move_top

      end

      def move_bottom

      end

      def start

      end

      def start_now

      end

      def stop

      end

      def verify

      end

      def re_announce

      end

      def finished?

      end

      def to_json

      end

      def method_missing(symbol, *args)
        string = symbol.to_s
        if string[-1] == '='
          string = string[0..-2]
          key = Transmission::Arguments::TorrentSet.real_key string
          return @attributes[key] = args.first if !!key
        else
          key = Transmission::Fields::TorrentGet.real_key string
          return @attributes[key] if !!key
        end
        super
      end

      class << self
        def all(options = {})
          rpc = options[:connector] || connector
          body = rpc.get_torrent nil, options
          body['torrents'].inject([]) do |torrents, torrent|
            torrents << Torrent.new(torrent)
          end
        end

        def find(id, options = {})
          rpc = options[:connector] || connector
          body = rpc.get_torrent [id], options
          raise TorrentNotFoundError if body['torrents'].size == 0
          Torrent.new body['torrents'].first
        end

        def add(options = {})
          rpc = options[:connector] || connector
          body = rpc.add_torrent options[:arguments]
          raise DuplicateTorrentError if body['torrent-duplicate']
          find body['torrent-added']['id']
        end

        def connector
          Transmission::Config.get_connector
        end
      end
    end
  end
end
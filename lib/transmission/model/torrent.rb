module Transmission
  module Model
    class Torrent
      class TorrentError < StandardError; end
      class TorrentNotFoundError < StandardError; end
      class MissingAttributesError < StandardError; end
      class DuplicateTorrentError < StandardError; end

      attr_accessor :attributes, :deleted, :connector

      def initialize(torrent_object, connector)
        @attributes = torrent_object
        @connector = connector
      end

      def delete!(remove_local_data = false)
        connector.remove_torrent [self.id], remove_local_data
        @deleted = true
      end

      def save!
        filtered = Transmission::Arguments::TorrentSet.filter @attributes
        filtered[:ids] = [self.id]
        connector.set_torrent filtered
      end

      def move_up!
        connector.move_up_torrent [self.id]
      end

      def move_down!
        connector.move_down_torrent [self.id]
      end

      def move_top!
        connector.move_top_torrent [self.id]
      end

      def move_bottom!
        connector.move_bottom_torrent [self.id]
      end

      def start!
        connector.start_torrent [self.id]
      end

      def start_now!
        connector.start_torrent_now [self.id]
      end

      def stop!
        connector.stop_torrent [self.id]
      end

      def verify!
        connector.verify_torrent [self.id]
      end

      def re_announce!
        connector.re_announce_torrent [self.id]
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
            torrents << Torrent.new(torrent, rpc)
          end
        end

        def find(id, options = {})
          rpc = options[:connector] || connector
          body = rpc.get_torrent [id], options
          raise TorrentNotFoundError if body['torrents'].size == 0
          Torrent.new body['torrents'].first, rpc
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
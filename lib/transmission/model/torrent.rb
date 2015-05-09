module Transmission
  module Model
    class Torrent
      class TorrentError < StandardError; end
      class TorrentNotFoundError < StandardError; end
      class MissingAttributesError < StandardError; end
      class DuplicateTorrentError < StandardError; end

      attr_accessor :attributes, :deleted, :connector, :torrents, :ids

      def initialize(torrent_object, connector)
        if torrent_object.is_a? Array
          is_single = torrent_object.size == 1
          @attributes = is_single ? torrent_object.first : {}
          @ids = is_single ? [@attributes['id'].to_i] : []
          @torrents = torrent_object.inject([]) do |torrents, torrent|
            @ids << torrent['id'].to_i
            torrents << Torrent.new([torrent], connector)
          end unless is_single
        end
        @connector = connector
      end

      def delete!(remove_local_data = false)
        connector.remove_torrent @ids, remove_local_data
        @deleted = true
      end

      def save!
        filtered = Transmission::Arguments::TorrentSet.filter @attributes
        connector.set_torrent @ids, filtered
      end

      def move_up!
        connector.move_up_torrent @ids
      end

      def move_down!
        connector.move_down_torrent @ids
      end

      def move_top!
        connector.move_top_torrent @ids
      end

      def move_bottom!
        connector.move_bottom_torrent @ids
      end

      def start!
        connector.start_torrent @ids
      end

      def start_now!
        connector.start_torrent_now @ids
      end

      def stop!
        connector.stop_torrent @ids
      end

      def verify!
        connector.verify_torrent @ids
      end

      def re_announce!
        connector.re_announce_torrent @ids
      end

      def torrent_set_location(options = {})
        connector.torrent_set_location options
      end


      def is_multi?
        @ids.size > 1
      end

      def finished?
        self.percent_done == 1
      end

      def reload!
        torrents = Torrent.find @ids, connector: @connector
        @ids = torrents.ids
        @attributes = torrents.attributes
        @torrents = torrents.torrents
      end

      def to_json
        if is_multi?
          @torrents.inject([]) do |torrents, torrent|
            torrents << torrent.to_json
          end
        else
          @attributes
        end
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
          body = rpc.get_torrent nil, options[:fields]
          Torrent.new body['torrents'], rpc
        end

        def find(id, options = {})
          rpc = options[:connector] || connector
          ids = id.is_a?(Array) ? id : [id]
          body = rpc.get_torrent ids, options[:fields]
          raise TorrentNotFoundError if body['torrents'].size == 0
          Torrent.new body['torrents'], rpc
        end

        def add(options = {})
          rpc = options[:connector] || connector
          body = rpc.add_torrent options[:arguments]
          raise DuplicateTorrentError if body['torrent-duplicate']
          find body['torrent-added']['id'], options
        end

        def start_all!(options = {})
          rpc = options[:connector] || connector
          rpc.start_torrent nil
        end

        def stop_all!(options = {})
          rpc = options[:connector] || connector
          rpc.stop_torrent nil
        end

        def connector
          Transmission::Config.get_connector
        end
      end
    end
  end
end
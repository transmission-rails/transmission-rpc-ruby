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

      def update

      end

      def delete!(remove_local_data = false)
        Transmission::Model::Torrent.connector.remove_torrent [self.attributes['id']], remove_local_data
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

      class << self
        def all
          response = connector.get_torrent
          body = JSON.parse response.body
          raise TorrentError unless response.status == 200 && body['result'] == 'success'
          body['arguments']['torrents'].inject([]) do |torrents, torrent|
            torrents << Torrent.new(torrent)
          end
        end

        def find(id)
          response = connector.get_torrent [id]
          body = JSON.parse response.body
          raise TorrentError unless response.status == 200 && body['result'] == 'success'
          raise TorrentNotFoundError if body['arguments']['torrents'].size == 0
          Torrent.new body['arguments']['torrents'].first
        end

        def add(options)
          raise MissingAttributesError unless options[:filename]
          response = connector.add_torrent options
          body = JSON.parse response.body
          raise TorrentError unless response.status == 200 && body['result'] == 'success'
          raise TorrentError if body['arguments'].empty?
          raise DuplicateTorrentError if body['arguments']['torrent-duplicate']
          id = body['arguments']['torrent-added']['id']
          find id
        end

        def connector
          Transmission::Config.get_connector
        end
      end
    end
  end
end
require File.join(File.dirname(__FILE__), 'rpc', 'connector')

module Transmission
  class RPC

    attr_accessor :session, :connector

    def initialize(options = {})
      @connector = Connector.new options
    end

    def get_session(fields = nil)
      fields = Transmission::Fields::SessionGet.new(fields)
      arguments = {fields: fields.to_fields}
      @connector.post method: 'session-get', arguments: arguments
    end

    def get_session_stats(fields = nil)
      fields = Transmission::Fields::SessionStats.new(fields)
      arguments = {fields: fields.to_fields}
      @connector.post method: 'session-stats', arguments: arguments
    end

    def close_session
      @connector.post method: 'session-close'
    end

    def test_port
      @connector.post method: 'port-test'
    end

    def blocklist
      @connector.post method: 'blocklist-update'
    end

    def free_space
      @connector.post method: 'free-space'
    end

    def get_torrent(ids, fields = nil)
      fields = Transmission::Fields::TorrentGet.new(fields)
      arguments = {fields: fields.to_fields}
      arguments[:ids] = ids if ids.is_a? Array
      @connector.post method: 'torrent-get', arguments: arguments
    end

    def set_torrent(ids, arguments)
      arguments[:ids] = ids
      arguments = Transmission::Arguments::TorrentSet.new(arguments)
      @connector.post method: 'torrent-set', arguments: arguments.to_arguments
    end

    def set_session(arguments)
      arguments = Transmission::Arguments::SessionSet.new(arguments)
      @connector.post method: 'session-set', arguments: arguments.to_arguments
    end

    def add_torrent(arguments)
      arguments = Transmission::Arguments::TorrentAdd.new(arguments)
      @connector.post method: 'torrent-add', arguments: arguments.to_arguments
    end

    def torrent_set_location(arguments)
      arguments = Transmission::Arguments::LocationSet.new(arguments)
      @connector.post method: 'torrent-set-location', arguments: arguments.to_arguments
    end

    def remove_torrent(ids, delete_local_data = false)
      @connector.post method: 'torrent-remove', arguments: {ids: ids, 'delete-local-data' => delete_local_data}
    end

    def start_torrent(ids)
      @connector.post method: 'torrent-start', arguments: id_arguments(ids)
    end

    def start_torrent_now(ids)
      @connector.post method: 'torrent-start-now', arguments: id_arguments(ids)
    end

    def stop_torrent(ids)
      @connector.post method: 'torrent-stop', arguments: id_arguments(ids)
    end

    def verify_torrent(ids)
      @connector.post method: 'torrent-verify', arguments: id_arguments(ids)
    end

    def re_announce_torrent(ids)
      @connector.post method: 'torrent-reannounce', arguments: id_arguments(ids)
    end

    def move_up_torrent(ids)
      @connector.post method: 'queue-move-up', arguments: id_arguments(ids)
    end

    def move_down_torrent(ids)
      @connector.post method: 'queue-move-down', arguments: id_arguments(ids)
    end

    def move_top_torrent(ids)
      @connector.post method: 'queue-move-top', arguments: id_arguments(ids)
    end

    def move_bottom_torrent(ids)
      @connector.post method: 'queue-move-bottom', arguments: id_arguments(ids)
    end

    private

    def id_arguments(ids)
      arguments = {}
      arguments[:ids] = ids if ids.is_a? Array
      arguments
    end

  end
end
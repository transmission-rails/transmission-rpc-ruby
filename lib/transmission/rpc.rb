require File.join(File.dirname(__FILE__), 'rpc', 'connector')

module Transmission
  class RPC

    def initialize(options)
      @connector = Connector.new options
    end

    def get_session
      @connector.post method: 'session-get'
    end

    def set_session(arguments)
      @connector.post method: 'session-set', arguments: arguments
    end

    def get_session_stats
      @connector.post method: 'session-stats'
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

    def get_torrent(ids = nil)
      arguments = {}
      arguments[:ids] = ids if ids.is_a?(Array)
      arguments[:fields] = Transmission::Arguments::TorrentGet::ATTRIBUTES
      @connector.post method: 'torrent-get', arguments: arguments
    end

    def set_torrent
      @connector.post method: 'torrent-set'
    end

    def add_torrent(arguments = {})
      @connector.post method: 'torrent-add', arguments: arguments
    end

    def remove_torrent(ids, delete_local_data = false)
      @connector.post method: 'torrent-remove', arguments: {ids: ids, 'delete-local-data' => delete_local_data}
    end

    def free_space
      @connector.post method: 'free-space'
    end

  end
end
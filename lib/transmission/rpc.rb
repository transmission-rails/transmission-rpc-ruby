require File.join(File.dirname(__FILE__), 'rpc', 'connector')
require File.join(File.dirname(__FILE__), 'rpc', 'method')

module Transmission
  class RPC
    def initialize(options = {})
      @connector = Connector.new(options)
    end

    ## Torrent Action Requests

    def torrent_start(ids)
      call_message('torrent-start', TorrentStart.new({ ids: ids }, rpc_version))
    end

    def torrent_start_now(ids)
      call_message('torrent-start-now', TorrentStartNow.new({ ids: ids }, rpc_version))
    end

    def torrent_stop(ids)
      call_message('torrent-stop', TorrentStop.new({ ids: ids }, rpc_version))
    end

    def torrent_verify(ids)
      call_message('torrent-verify', TorrentVerify.new({ ids: ids }, rpc_version))
    end

    def torrent_reannounce(ids)
      call_message('torrent-reannounce', TorrentReannounce.new({ ids: ids }, rpc_version))
    end

    ## Torrent Set

    def torrent_set(ids, arguments = {})
      call_message('torrent-set', TorrentSet.new(arguments.merge(ids: ids), rpc_version))
    end

    ## Torrent Get

    def torrent_get(ids, fields = [])
      call_message('torrent-get', TorrentGet.new({ ids: ids, fields: fields }, rpc_version))
    end

    ## Torrent Add

    def torrent_add(arguments = {})
      call_message('torrent-add', TorrentAdd.new({ ids: ids }, rpc_version))
    end

    ## Torrent Remove

    def torrent_remove(ids, delete_local_data = false)
      call_message('torrent-start', TorrentRemove.new({ ids: ids, delete_local_data: delete_local_data }, rpc_version))
    end

    ## Torrent Set Location

    def torrent_set_location(ids, arguments = {})
      call_message('torrent-set-location', TorrentSetLocation.new(arguments.merge({ ids: ids }), rpc_version))
    end

    ## Torrent Rename Path

    def torrent_rename_path(ids, arguments = {})
      call_message('torrent-rename-path', TorrentRenamePath.new(arguments.merge({ ids: ids }), rpc_version))
    end

    ## Session Set

    def session_set(arguments = {})
      call_message('session-set', SessionSet.new(arguments, rpc_version))
    end

    ## Session Get

    def session_get
      call_message('session-set', SessionGet.new({}, rpc_version))
    end

    ## Session Stats

    def session_stats
      call_message('session-stats', SessionStats.new({}, rpc_version))
    end

    ## Blocklist

    def blocklist_update
      call_message('blocklist-update', BlocklistUpdate.new({}, rpc_version))
    end

    ## Port Checking

    def port_test
      call_message('port-test', PortTest.new({}, rpc_version))
    end

    ## Session Shutdown

    def session_close
      call_message('session-close', SessionClose.new({}, rpc_version))
    end

    ## Queue Movements

    def queue_move_up(ids)
      call_message('queue-move-up', QueueMoveUp.new({ ids: ids }, rpc_version))
    end

    def queue_move_down(ids)
      call_message('queue-move-down', QueueMoveDown.new({ ids: ids }, rpc_version))
    end

    def queue_move_top(ids)
      call_message('queue-move-top', QueueMoveTop.new({ ids: ids }, rpc_version))
    end

    def queue_move_bottom(ids)
      call_message('queue-move-bottom', QueueMoveBottom.new({ ids: ids }, rpc_version))
    end

    ## Free Space

    def free_space
      call_message('free-space', FreeSpace.new({}, rpc_version))
    end

    ## RPC Version

    def rpc_version
      @connector.rpc_version
    end

    private

    def call_message(name, method)
      method.validate
      response = @connector.post(method: name, arguments: method.to_arguments)
      # method.build_response(response)
    end

  end
end

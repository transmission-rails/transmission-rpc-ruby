module Transmission
  class Arguments
    class SessionStats < Transmission::Arguments

      ATTRIBUTES = [
          'activeTorrentCount',
          'downloadSpeed',
          'pausedTorrentCount',
          'torrentCount',
          'uploadSpeed',
          'cumulative-stats',
          'current-stats'
      ]

    end
  end
end
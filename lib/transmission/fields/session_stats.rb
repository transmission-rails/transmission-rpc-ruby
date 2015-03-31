module Transmission
  class Fields
    class SessionStats < Transmission::Fields

      ATTRIBUTES = [
          {field: 'activeTorrentCount'},
          {field: 'downloadSpeed'},
          {field: 'pausedTorrentCount'},
          {field: 'torrentCount'},
          {field: 'uploadSpeed'},
          {field: 'cumulative-stats'},
          {field: 'current-stats'}
      ]

    end
  end
end
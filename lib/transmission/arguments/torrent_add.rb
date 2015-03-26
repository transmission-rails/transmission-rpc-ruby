module Transmission
  class Arguments
    class TorrentAdd < Transmission::Arguments

      ATTRIBUTES = [
          'cookies',
          'download-dir',
          'filename',
          'metainfo',
          'paused',
          'peer-limit',
          'bandwidthPriority',
          'files-wanted',
          'files-unwanted',
          'priority-high',
          'priority-low',
          'priority-normal'
      ]

    end
  end
end
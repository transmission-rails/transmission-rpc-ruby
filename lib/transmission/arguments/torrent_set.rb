module Transmission
  class Arguments
    class TorrentSet < Transmission::Arguments

      ATTRIBUTES = [
          'bandwidthPriority',
          'downloadLimit',
          'downloadLimited',
          'downloadLimit',
          'files-wanted',
          'files-unwanted',
          'honorsSessionLimits',
          'ids',
          'location',
          'peer-limit',
          'priority-high',
          'priority-low',
          'priority-normal',
          'queuePosition',
          'seedIdleLimit',
          'seedIdleMode',
          'seedRatioLimit',
          'seedRatioMode',
          'trackerAdd',
          'trackerRemove',
          'trackerReplace',
          'uploadLimit',
          'uploadLimited',
          'uploadLimit'
      ]

    end
  end
end
module Transmission
  class Arguments
    class TorrentSet < Transmission::Arguments

      ATTRIBUTES = [
          {field: 'bandwidthPriority'},
          {field: 'downloadLimit'},
          {field: 'downloadLimited'},
          {field: 'downloadLimit'},
          {field: 'files-wanted'},
          {field: 'files-unwanted'},
          {field: 'honorsSessionLimits'},
          {field: 'ids'},
          {field: 'location'},
          {field: 'peer-limit'},
          {field: 'priority-high'},
          {field: 'priority-low'},
          {field: 'priority-normal'},
          {field: 'queuePosition'},
          {field: 'seedIdleLimit'},
          {field: 'seedIdleMode'},
          {field: 'seedRatioLimit'},
          {field: 'seedRatioMode'},
          {field: 'trackerAdd'},
          {field: 'trackerRemove'},
          {field: 'trackerReplace'},
          {field: 'uploadLimit'},
          {field: 'uploadLimited'},
          {field: 'uploadLimit'}
      ]

    end
  end
end
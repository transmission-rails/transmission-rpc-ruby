module Transmission
  class RPC
    class TorrentSet < Method

      mutator 'bandwidthPriority', type: Integer
      mutator 'downloadLimit', type: Integer
      mutator 'downloadLimited', accepts: [true, false]
      mutator 'files-wanted', type: Array
      mutator 'files-unwanted', type: Array
      mutator 'honorsSessionLimits', accepts: [true, false]
      mutator 'ids', type: Array
      mutator 'location', type: String
      mutator 'peer-limit', type: Integer
      mutator 'priority-high', type: Array
      mutator 'priority-low', type: Array
      mutator 'priority-normal', type: Array
      mutator 'queuePosition', type: Integer
      mutator 'seedIdleLimit', type: Integer
      mutator 'seedIdleMode', type: Integer
      mutator 'seedRatioLimit', type: Float
      mutator 'seedRatioMode', type: Integer
      mutator 'trackerAdd', type: Array
      mutator 'trackerReplace', type: Array
      mutator 'uploadLimit', type: Integer
      mutator 'uploadLimited', accepts: [true, false]

    end
  end
end

module Transmission
  class RPC
    class TorrentAdd < Method

      mutator 'cookies', type: String
      mutator 'downloadDir', type: String
      mutator 'filename', type: String
      mutator 'metafile', type: String
      mutator 'paused', accepts: [true, false]
      mutator 'peer-limit', type: Integer
      mutator 'bandwidthPriority', type: Integer
      mutator 'files-wanted', type: Array
      mutator 'files-unwanted', type: Array
      mutator 'priority-high', type: Array
      mutator 'priority-low', type: Array
      mutator 'priority-normal', type: Array

    end
  end
end

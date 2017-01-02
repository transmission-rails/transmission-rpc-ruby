module Transmission
  class RPC
    class TorrentStartNow < Method
      min_version 14

      mutator 'ids', type: Array

    end
  end
end

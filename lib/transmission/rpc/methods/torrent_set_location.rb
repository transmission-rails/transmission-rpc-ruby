module Transmission
  class RPC
    class TorrentSetLocation < Method
      min_version 6

      mutator 'ids', type: Array
      mutator 'location', type: String
      mutator 'move', accepts: [true, false]

    end
  end
end

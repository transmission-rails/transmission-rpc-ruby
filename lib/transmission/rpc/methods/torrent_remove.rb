module Transmission
  class RPC
    class TorrentRemove < Method
      min_version 3

      mutator 'ids', type: Array
      mutator 'delete-local-data', accepts: [true, false]

    end
  end
end

module Transmission
  class RPC
    class TorrentReannounce < Method
      min_version 5

      mutator 'ids', type: Array

    end
  end
end

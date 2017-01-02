module Transmission
  class RPC
    class TorrentRenamePath < Method
      min_version 15

      mutator 'ids', type: Array
      mutator 'path', type: String
      mutator 'name', type: String

    end
  end
end

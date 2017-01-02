module Transmission
  class RPC
    class FreeSpace < Method
      min_version 14

      mutator 'path', type: String

    end
  end
end

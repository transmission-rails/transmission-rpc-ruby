module Transmission
  class RPC
    class QueueMoveTop < Method
      min_version 14

      mutator 'ids', type: Array

    end
  end
end

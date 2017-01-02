module Transmission
  class RPC
    class QueueMoveDown < Method
      min_version 14

      mutator 'ids', type: Array

    end
  end
end

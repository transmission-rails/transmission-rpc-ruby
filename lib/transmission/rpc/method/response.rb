module Transmission
  class RPC
    class Method
      class Response
        def initialize(&block)
          @fields, @root = {}, Node.new(:arguments, {}, &block)
          block.call(@root)
        end

        def build_response(response_body)
          @root.build_response(response_body)
        end

        def structure(rpc_version = RPC_VERSION.MAX)
          @root.structure(rpc_version)
        end

        class Node
          attr_reader :key, :nodes

          def initialize(key, options, &block)
            @key, @options, @nodes = key, options, {}
            block.call(self)
          end

          def compatible?(rpc_version)
            min_version <= rpc_version && max_version >= rpc_version
          end

          def field(key, options = {})
            underscore_key = Utils.underscore_key(key)
            nodes[underscore_key] = Leaf.new(underscore_key, options.merge({field: key}))
          end

          def array(key, options = {}, &block)
            underscore_key = Utils.underscore_key(key)
            nodes[underscore_key] = ArrayNode.new(underscore_key, options.merge({field: key}), &block)
          end

          def object(key, options = {}, &block)
            underscore_key = Utils.underscore_key(key)
            nodes[underscore_key] = Node.new(underscore_key, options.merge({field: key}), &block)
          end

          def min_version
            @options[:min_version] || RPC_VERSION.MIN
          end

          def max_version
            @options[:max_version] || RPC_VERSION.MAX
          end

          def build_response(response_body)
            {}
          end

          def structure(rpc_version)
            nodes.each_with_object({}) do |(key, node), arguments|
              next unless node.compatible?(rpc_version)
              arguments[node.key] = if node.is_a?(Leaf)
                node.type
              else
                node.structure(rpc_version)
              end
            end
          end
        end

        class ArrayNode < Node
          def structure(rpc_version)
            [super(rpc_version)]
          end
        end

        class Leaf
          attr_reader :key, :type

          def initialize(key, options)
            @key, @type, @options = key, options[:type], options
          end

          def compatible?(rpc_version)
            min_version <= rpc_version && max_version >= rpc_version
          end

          def min_version
            @options[:min_version] || RPC_VERSION.MIN
          end

          def max_version
            @options[:max_version] || RPC_VERSION.MAX
          end

          def build_response(response_body)

          end
        end
      end
    end
  end
end

module Transmission
  class RPC
    class Method
      class Field
        attr_reader :key, :errors
        attr_accessor :owner, :rpc_version

        def initialize(key, options)
          @key, @options, @errors = key, options, []
        end

        def validate
          @errors = []
          validate_version { |e| @errors << e }
        end

        def validate!
          validate_version { |e| ArgumentError.new(e) }
        end

        def compatible?
          owner.class.fields.any? do |key, options|
            # Find alternative fields based on same key
          end
          min_version <= rpc_version && max_version >= rpc_version
        end

        def min_version
          @options[:min_version] || RPC_VERSION.MIN
        end

        def max_version
          @options[:max_version] || RPC_VERSION.MAX
        end

        private

        def validate_version
          unless compatible?
            yield("#{key} field is only available in versions #{min_version} to #{max_version}")
          end
        end
      end
    end
  end
end

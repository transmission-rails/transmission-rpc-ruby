module Transmission
  class RPC
    class Method
      class Mutator
        attr_reader :key, :errors
        attr_accessor :value, :owner, :rpc_version

        def initialize(key, options)
          @key, @options, @errors = key, options, []
        end

        def validate
          @errors = []
          validate_version  { |e| @errors << e }
          validate_type     { |e| @errors << e }
          validate_accepts  { |e| @errors << e }
          validate_fields   { |e| @errors << e }
          validate_validate { |e| @errors << e }
        end

        def validate!
          validate_version  { |e| raise ArgumentError.new(e) }
          validate_type     { |e| raise ArgumentError.new(e) }
          validate_accepts  { |e| raise ArgumentError.new(e) }
          validate_fields   { |e| raise ArgumentError.new(e) }
          validate_validate { |e| raise ArgumentError.new(e) }
        end

        def compatible?
          owner.class.mutators.any? do |key, options|
            # Find alternative mutators based on same key
          end
          min_version <= rpc_version && max_version >= rpc_version
        end

        def to_arguments
          { backward_compatible_field => argument_value }
        end

        def min_version
          @options[:min_version] || RPC_VERSION.MIN
        end

        def max_version
          @options[:max_version] || RPC_VERSION.MAX
        end

        private

        def validate_type
          if type && !value.is_a?(type)
            yield("#{key} needs to be type #{type}. #{value} is of type #{value.class}")
          end
        end

        def validate_accepts
          if accepts && !accepts.include?(value)
            yield("#{key} only accepts [#{accepts.join(', ')}], not #{value}")
          end
        end

        def validate_version
          unless compatible?
            yield("#{key} mutator is only available in versions #{min_version} to #{max_version}")
          end
        end

        def validate_fields
          if fields_mutator? && (value.map(&:to_sym) - field_keys).any?
            yield("Invalid fields: '#{(value.map(&:to_sym) - field_keys)}'")
          end
        end

        def validate_validate
          if validate_name
            owner.send(validate_name, self) do |e|
              yield(e)
            end
          end
        end

        def fields_mutator?
          key == :fields
        end

        def field_keys
          owner.class.fields.map { |key, options| key }
        end

        def argument_value
          fields_mutator? ? field_keys & value : value
        end

        def backward_compatible_field
          # Find backward compatible field
          @options[:field]
        end

        def type
          @options[:type]
        end

        def accepts
          @options[:accepts]
        end

        def validate_name
          @options[:validate]
        end
      end
    end
  end
end

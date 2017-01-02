require File.join(File.dirname(__FILE__), 'method', 'mutator')
require File.join(File.dirname(__FILE__), 'method', 'field')
require File.join(File.dirname(__FILE__), 'method', 'response')

module Transmission
  class RPC
    class Method
      attr_reader :mutators, :rpc_version

      def initialize(arguments = {}, rpc_version)
        @arguments, @rpc_version, @errors = arguments, rpc_version, []
      end

      def compatible?
        min_version <= rpc_version && max_version >= rpc_version
      end

      def to_arguments
        mutators.inject({}) do |arguments, (key, mutator)|
          arguments.merge(mutator.to_arguments)
        end
      end

      def validate
        @errors = []
        validate_version { |e| @errors << e }
        mutators.each    { |key, mutator| mutator.validate }
        fields.each      { |key, field| field.validate }
      end

      def validate!
        validate_version { |e| raise ArgumentError.new(e) }
        mutators.each    { |key, mutator| mutator.validate! }
        fields.each      { |key, field| field.validate! }
      end

      def errors
        @errors + mutators_errors + fields_errors
      end

      def min_version
        self.class.min_version || RPC_VERSION.MIN
      end

      def max_version
        self.class.max_version || RPC_VERSION.MAX
      end

      def mutators
        @mutators ||= @arguments.each_with_object({}) do |(key, value), mutators|
          if mutator = self.class.mutators[key]
            mutators[key] = mutator.clone.tap do |mutator|
              mutator.value = value
              mutator.owner = self
              mutator.rpc_version = rpc_version
            end
          end
        end
      end

      def fields
        return [] unless @arguments[:fields]
        @fields ||= @arguments[:fields].each_with_object({}) do |key, fields|
          if field = self.class.fields[key.to_sym]
            fields[key] = field.clone.tap do |field|
              field.owner = self
              field.rpc_version = rpc_version
            end
          end
        end
      end

      def build_response(response_body)
        self.class.response.build_response(response_body)
      end

      def name
        Utils.underscore_key(self.class.name.split('::').last)
      end

      private

      def validate_version
        unless compatible?
          yield("#{method_name} method is only available in versions #{min_version} to #{max_version}")
        end
      end

      def mutators_errors
        mutators.inject([]) { |errors, (key, mutator)| errors.concat(mutator.errors) }
      end

      def fields_errors
        fields.inject([]) { |errors, (key, field)| errors.concat(field.errors) }
      end

      class << self
        def mutator(name, options = {})
          key = Utils.underscore_key(name)
          mutators[key] = Mutator.new(key, options.merge(field: name))
        end

        def mutators
          @mutators ||= {}
        end

        def field(name, options = {})
          key = Utils.underscore_key(name)
          fields[key] = Field.new(key, options.merge(field: name))
        end

        def fields
          @fields ||= {}
        end

        def response(&block)
          @response = Response.new(&block) if block
          @response
        end

        def min_version(version = nil)
          @min_version = version if version
          @min_version || RPC_VERSION.MIN
        end

        def max_version(version = nil)
          @max_version = version if version
          @max_version || RPC_VERSION.MAX
        end

        def compatible_mutator(key, rpc_version)

        end
      end
    end
  end
end

Dir[File.join(File.dirname(__FILE__), 'methods', '*.rb')].each { |file| require file }

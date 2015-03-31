require File.join(File.dirname(__FILE__), 'fields', 'torrent_get')
require File.join(File.dirname(__FILE__), 'fields', 'session_get')
require File.join(File.dirname(__FILE__), 'fields', 'session_stats')
require File.join(File.dirname(__FILE__), 'utils')

module Transmission
  class Fields
    class InvalidField < StandardError; end

    attr_accessor :fields

    ATTRIBUTES = []

    def initialize(fields = nil)
      @fields = fields.inject([]) do |fields, field|
        found = self.class::ATTRIBUTES.select { |attr| attr[:field] == field}
        raise Transmission::Fields::InvalidField, field if found.empty?
        fields << field
      end if fields
      @fields = self.class::ATTRIBUTES.collect do |key|
        key[:field]
      end if fields.nil?
    end

    def to_fields
      @fields
    end

    class << self
      include Transmission::Utils

      def is_valid?(key)
        is_valid_key? key, self::ATTRIBUTES
      end

      def real_key(key)
        option_key key, self::ATTRIBUTES
      end
    end

  end
end
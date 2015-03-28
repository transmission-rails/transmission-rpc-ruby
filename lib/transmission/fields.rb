require File.join(File.dirname(__FILE__), 'fields', 'torrent_get')
require File.join(File.dirname(__FILE__), 'fields', 'session_get')
require File.join(File.dirname(__FILE__), 'fields', 'session_stats')

module Transmission
  class Fields
    class InvalidField < StandardError; end

    attr_accessor :fields

    def initialize(fields = nil)
      @fields = fields.inject([]) do |fields, field|
        found = self.class::ATTRIBUTES.select { |attr| attr[:field] == field}
        raise Transmission::Fields::InvalidField, field if found.empty?
        fields << field
      end if fields
      @fields = self.class::ATTRIBUTES.collect do |key, value|
        key[:field]
      end if fields.nil?
    end

    def to_fields
      @fields
    end

  end
end
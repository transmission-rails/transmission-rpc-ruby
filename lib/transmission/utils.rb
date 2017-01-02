module Transmission
  module Utils
    def self.underscore_key(key)
      key.to_s
        .gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .tr("-", "_")
        .downcase
        .to_sym
    end
  end
end

require 'forwardable'
require 'wayback/error/configuration_error'

module Wayback
  module Configurable
    extend Forwardable
    attr_accessor :endpoint, :connection_options, :identity_map, :middleware
    def_delegator :options, :hash

    class << self

      def keys
        @keys ||= [
          :endpoint,
          :connection_options,
          :identity_map,
          :middleware
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    #
    # @raise [Wayback::Error::ConfigurationError] Error is raised when supplied
    #   wayback credentials are not a String or Symbol.
    def configure
      yield self
      self
    end

    def reset!
      Wayback::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Wayback::Default.options[key])
      end
      self
    end
    alias setup reset!

  private

    # @return [Hash]
    def options
      Hash[Wayback::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

  end
end

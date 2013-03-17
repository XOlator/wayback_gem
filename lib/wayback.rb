require 'wayback/archive'
require 'wayback/client'
require 'wayback/configurable'
require 'wayback/default'
require 'wayback/page'

module Wayback
  class << self
    include Wayback::Configurable

    # Delegate to a Wayback::Client
    #
    # @return [Wayback::Client]
    def client
      @client = Wayback::Client.new(options) unless defined?(@client) && @client.hash == options.hash
      @client
    end

    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end
end

Wayback.setup
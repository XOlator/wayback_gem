require 'faraday'
require 'wayback/configurable'
require 'wayback/error/client_error'
require 'wayback/error/server_error'
require 'wayback/response/raise_error'
require 'wayback/response/parse_memento'
require 'wayback/response/parse_memento_page'
require 'wayback/version'

module Wayback
  module Default
    ENDPOINT = 'http://api.wayback.archive.org' unless defined? Wayback::Default::ENDPOINT
    CONNECTION_OPTIONS = {
      :headers => {
        # :accept => 'application/json',
        :user_agent => "Wayback Ruby Gem #{Wayback::Version}",
      },
      :request => {
        :open_timeout => 5,
        :timeout => 10,
      },
      :ssl => {
        :verify => false
      },
    } unless defined? Wayback::Default::CONNECTION_OPTIONS
    IDENTITY_MAP = false unless defined? Wayback::Default::IDENTITY_MAP
    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Convert request params to "www-form-urlencoded"
      builder.use Faraday::Request::UrlEncoded
      # Handle 4xx server responses
      builder.use Wayback::Response::RaiseError, Wayback::Error::ClientError
      # Handle 5xx server responses
      builder.use Wayback::Response::RaiseError, Wayback::Error::ServerError
      # Parse link-format with custom memento parser
      builder.use Wayback::Response::ParseMemento
      # Parse link-format with custom memento parser
      builder.use Wayback::Response::ParseMementoPage
      # Set Faraday's HTTP adapter
      builder.adapter Faraday.default_adapter
    end unless defined? Wayback::Default::MIDDLEWARE

    class << self

      # @return [Hash]
      def options
        Hash[Wayback::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @note This is configurable in case you want to use a Wayback Machine-compatible endpoint.
      # @return [String]
      def endpoint
        ENDPOINT
      end

      def connection_options
        CONNECTION_OPTIONS
      end

      def identity_map
        IDENTITY_MAP
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end

    end
  end
end

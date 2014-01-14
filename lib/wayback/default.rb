require 'faraday'
require 'faraday_middleware'
require 'wayback/configurable'
require 'wayback/error/client_error'
require 'wayback/error/server_error'
require 'wayback/response/raise_error'
require 'wayback/response/parse_availability'
require 'wayback/response/parse_memento'
require 'wayback/response/parse_memento_page'
require 'wayback/version'

module Wayback
  module Default
    ENDPOINT = 'http://web.archive.org' unless defined? Wayback::Default::ENDPOINT
    ENDPOINT_PATH = '/web' unless defined? Wayback::Default::ENDPOINT_PATH
    JSON_ENDPOINT = 'http://archive.org' unless defined? Wayback::Default::JSON_ENDPOINT
    JSON_ENDPOINT_PATH = '/wayback' unless defined? Wayback::Default::JSON_ENDPOINT_PATH
    CONNECTION_OPTIONS = {
      :headers  => {:user_agent => "Wayback Ruby Gem #{Wayback::Version}"},
      :request  => {:open_timeout => 5, :timeout => 10},
      :ssl      => {:verify => false},
    } unless defined? Wayback::Default::CONNECTION_OPTIONS
    IDENTITY_MAP = false unless defined? Wayback::Default::IDENTITY_MAP
    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Convert request params to "www-form-urlencoded"
      builder.use Faraday::Request::UrlEncoded
      # Follow redirects
      builder.use FaradayMiddleware::FollowRedirects
      # Handle 4xx server responses
      builder.use Wayback::Response::RaiseError, Wayback::Error::ClientError
      # Handle 5xx server responses
      builder.use Wayback::Response::RaiseError, Wayback::Error::ServerError
      # Parse closest available JSON result
      builder.use Wayback::Response::ParseAvailablity
      # Parse memento page
      builder.use Wayback::Response::ParseMementoPage
      # Parse link-format with custom memento parser
      builder.use Wayback::Response::ParseMemento
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

      def endpoint_path
        ENDPOINT_PATH
      end

      def json_endpoint
        JSON_ENDPOINT
      end

      def json_endpoint_path
        JSON_ENDPOINT_PATH
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

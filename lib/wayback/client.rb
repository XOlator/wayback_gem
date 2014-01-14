require 'faraday'
require 'wayback/api/archive'
require 'wayback/configurable'
require 'wayback/error/client_error'
require 'wayback/error/decode_error'
require 'uri'

module Wayback
  # Wrapper for the Wayback Memento/Timehop API
  class Client
    include Wayback::API::Archive
    include Wayback::Configurable

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Wayback::Client]
    def initialize(options={})
      Wayback::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Wayback.instance_variable_get(:"@#{key}"))
      end
    end

    # Perform an HTTP DELETE request
    def delete(path, params={})
      request(:delete, path, params)
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params={})
      signature_params = params.values.any?{|value| value.respond_to?(:to_io)} ? {} : params
      request(:post, path, params, signature_params)
    end

    # Perform an HTTP PUT request
    def put(path, params={})
      request(:put, path, params)
    end

    # Perform an HTTP GET request from JSON API
    def json_get(path, params={})
      json_request(:get, path, params)
    end

  private

    def request(method, path, params={}, signature_params=params)
      connection.send(method.to_sym, path.insert(0, @endpoint_path), params).env
    rescue Faraday::Error::ClientError
      raise Wayback::Error::ClientError
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware))
    end

    def json_request(method, path, params={}, signature_params=params)
      json_connection.send(method.to_sym, path.insert(0, @json_endpoint_path), params).env
    rescue Faraday::Error::ClientError
      raise Wayback::Error::ClientError
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def json_connection
      @json_connection ||= Faraday.new(@json_endpoint, @connection_options.merge(:builder => @middleware))
    end

  end
end

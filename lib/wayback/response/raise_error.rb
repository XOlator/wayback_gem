require 'faraday'
require 'wayback/error/bad_gateway'
require 'wayback/error/bad_request'
require 'wayback/error/forbidden'
require 'wayback/error/gateway_timeout'
require 'wayback/error/internal_server_error'
require 'wayback/error/not_acceptable'
require 'wayback/error/not_found'
require 'wayback/error/service_unavailable'
require 'wayback/error/too_many_requests'
require 'wayback/error/unauthorized'
require 'wayback/error/unprocessable_entity'

module Wayback
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = @klass.errors[status_code]
        raise error_class.from_response(env) if error_class
      end

      def initialize(app, klass)
        @klass = klass
        super(app)
      end

    end
  end
end

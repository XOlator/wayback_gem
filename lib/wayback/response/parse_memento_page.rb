require 'faraday'

module Wayback
  module Response
    class ParseMementoPage < Faraday::Response::Middleware

      def parse(body, *opts)
        body
      end

      def on_complete(env)
        if respond_to?(:parse) && env[:response_headers]['content-type'].match(/^text\/html/i)
          env[:body] = {:id => env[:url].to_s, :html => parse(env[:body])} unless [204, 301, 302, 304].include?(env[:status])
        end
      end

    end
  end
end

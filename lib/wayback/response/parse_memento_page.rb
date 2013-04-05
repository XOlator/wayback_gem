require 'faraday'

module Wayback
  module Response
    class ParseMementoPage < Faraday::Response::Middleware

      def parse(body, *opts)
        body
      end

      def on_complete(env)
        if respond_to?(:parse) && env[:response_headers]['content-type'].match(/^(text\/html|application\/octet-stream)/i)
          unless [204, 301, 302, 304].include?(env[:status])
            env[:body] = {:id => env[:url].to_s, :html => parse(env[:body])}
          else
            env[:body] = {:id => env[:url].to_s, :error => env[:status]}
          end
        end
      end

    end
  end
end

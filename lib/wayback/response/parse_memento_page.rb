require 'faraday'

module Wayback
  module Response
    class ParseMementoPage < Faraday::Response::Middleware

      def parse(body, *opts)
        body
      end

      def on_complete(env)
        if respond_to?(:parse) && ((env[:response_headers] && env[:response_headers]['content-type']) || '').match(/^(text\/html|application\/octet-stream)/i)
          if [204, 301, 302, 304].include?(env[:status])
            env[:body] = {:id => env[:url].to_s, :error => env[:status]}
          else
            env[:body] = {:id => env[:url].to_s, :html => parse(env[:body])}
          end
        end
      end

    end
  end
end

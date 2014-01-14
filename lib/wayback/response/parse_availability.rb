require 'faraday'
require 'json'

module Wayback
  module Response
    class ParseAvailablity < Faraday::Response::Middleware

      def parse(body)
        case body
          when /^\{/
            obj = JSON.parse(body, :symbolize_names => true)[:archived_snapshots][:closest] rescue nil
            obj[:id] = obj[:timestamp] if obj && obj[:timestamp]
            obj
          else
            nil
        end
      end

      def on_complete(env)
        if respond_to?(:parse) && ((env[:response_headers] && env[:response_headers]['content-type']) || '').match(/^application\/javascript/i)
          env[:body] = parse(env[:body]) unless unparsable_status_codes.include?(env[:status])
        end
      end

      def unparsable_status_codes
        [204, 301, 302, 304]
      end
    end
  end
end
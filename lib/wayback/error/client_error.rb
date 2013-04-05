require 'wayback/error'

module Wayback
  class Error
    # Raised when Wayback returns a 4xx HTTP status code or there's an error in Faraday
    class ClientError < Wayback::Error

      # Create a new error from an HTTP environment
      #
      # @param response [Hash]
      # @return [Wayback::Error]
      def self.from_response(response={})
        new(parse_error(response[:body]), response[:response_headers])
      end

    private

      def self.parse_error(body)
        if body.nil? || body.is_a?(String)
          ''
        # elsif body[:error]
        #   body[:error]
        end
      end

    end
  end
end

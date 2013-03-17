require 'wayback/error/server_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 502
    class BadGateway < Wayback::Error::ServerError
      HTTP_STATUS_CODE = 502
      MESSAGE = "Wayback is down or being upgraded."
    end
  end
end

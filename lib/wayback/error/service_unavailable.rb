require 'wayback/error/server_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 503
    class ServiceUnavailable < Wayback::Error::ServerError
      HTTP_STATUS_CODE = 503
      MESSAGE = "(__-){ Wayback is over capacity."
    end
  end
end

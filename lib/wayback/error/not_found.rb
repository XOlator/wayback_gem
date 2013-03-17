require 'wayback/error/client_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 404
    class NotFound < Wayback::Error::ClientError
      HTTP_STATUS_CODE = 404
    end
  end
end

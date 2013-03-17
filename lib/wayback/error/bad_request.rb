require 'wayback/error/client_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 400
    class BadRequest < Wayback::Error::ClientError
      HTTP_STATUS_CODE = 400
    end
  end
end

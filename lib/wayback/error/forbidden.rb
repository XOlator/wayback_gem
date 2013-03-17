require 'wayback/error/client_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 403
    class Forbidden < Wayback::Error::ClientError
      HTTP_STATUS_CODE = 403
    end
  end
end

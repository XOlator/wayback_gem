require 'wayback/error/client_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 401
    class Unauthorized < Wayback::Error::ClientError
      HTTP_STATUS_CODE = 401
    end
  end
end

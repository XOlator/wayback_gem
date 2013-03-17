require 'wayback/error/client_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 404
    class UnprocessableEntity < Wayback::Error::ClientError
      HTTP_STATUS_CODE = 422
    end
  end
end

require 'wayback/error/client_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 406
    class NotAcceptable < Wayback::Error::ClientError
      HTTP_STATUS_CODE = 406
    end
  end
end

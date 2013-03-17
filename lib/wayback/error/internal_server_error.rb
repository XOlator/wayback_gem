require 'wayback/error/server_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 500
    class InternalServerError < Wayback::Error::ServerError
      HTTP_STATUS_CODE = 500
      MESSAGE = "Something is technically wrong."
    end
  end
end

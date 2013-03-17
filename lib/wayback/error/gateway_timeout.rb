require 'wayback/error/server_error'

module Wayback
  class Error
    # Raised when Wayback returns the HTTP status code 504
    class GatewayTimeout < Wayback::Error::ServerError
      HTTP_STATUS_CODE = 504
      MESSAGE = "The Wayback servers are up, but the request couldn't be serviced due to some failure within our stack. Try again later."
    end
  end
end

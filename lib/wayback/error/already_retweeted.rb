require 'wayback/error/forbidden'

module Wayback
  class Error
    # Raised when a Tweet has already been retweeted
    class AlreadyRetweeted < Wayback::Error
      MESSAGE = "sharing is not permissible for this status (Share validations failed)"
    end
  end
end

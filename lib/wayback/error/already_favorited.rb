require 'wayback/error/forbidden'

module Wayback
  class Error
    # Raised when a Tweet has already been favorited
    class AlreadyFavorited < Wayback::Error
      MESSAGE = "You have already favorited this status"
    end
  end
end

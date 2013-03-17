require 'wayback/error'

module Wayback
  class Error
    # Raised when JSON parsing fails
    class DecodeError < Wayback::Error
    end
  end
end

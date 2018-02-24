module Wayback
  class Version
    MAJOR = 0 unless defined? Wayback::Version::MAJOR
    MINOR = 3 unless defined? Wayback::Version::MINOR
    PATCH = 4 unless defined? Wayback::Version::PATCH
    PRE = nil unless defined? Wayback::Version::PRE

    class << self

      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end

  end
end
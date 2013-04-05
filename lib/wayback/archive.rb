require 'wayback/identity'

module Wayback
  class Archive < Wayback::Identity

    attr_reader :dates, :first_date, :last_date, :original_url

    # Nicer method for mapping
    def url; id; end

  private


  end
end

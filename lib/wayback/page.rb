require 'wayback/identity'

module Wayback
  class Page < Wayback::Identity

    attr_reader :html, :error


    def to_s
      html || ''
    end


  private


  end
end

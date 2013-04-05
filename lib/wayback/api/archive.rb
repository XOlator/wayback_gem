require 'time'
require 'wayback/api/utils'
require 'wayback/error/not_found'

module Wayback
  module API
    module Archive
      include Wayback::API::Utils

      # Return a list of archived pages
      #
      # @return [Wayback::Archive]
      # @param url [String] The page that of which was archived.
      # @param options [Hash] A customizable set of options.
      # @example Return the list of available archives for a web page.
      #   Wayback.list('http://gleu.ch')
      def list(url, options={})
        object_from_response(Wayback::Archive, :get, "/list/timemap/link/#{url}", options)
      end

      # Returns the HTML contents of an archive page, fetched by date
      #
      # @raise [Wayback::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Wayback::Page]
      # @param url [String] The page that of which was archived.
      # @param options [Hash] A customizable set of options.
      # @example Return the HTML archive for the page.
      #   Wayback.page('http://gleu.ch')
      #   Wayback.page('http://gleu.ch', 'Tue, 17 Jan 2012 07:33:06 GMT')
      #   Wayback.page('http://gleu.ch', '20130113125339')
      #   Wayback.page('http://gleu.ch', :first)
      #   Wayback.page('http://gleu.ch', :last)
      def page(url, date=0, options={})
        date = 0 if date == :first
        date = Time.now if date == :last
        date = Time.parse(date).to_i unless [Fixnum,Time,Integer].include?(date.class)
        object_from_response(Wayback::Page, :get, "/memento/#{date.to_i}/#{url}", options)
      end

    end
  end
end

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
      # @param url [String] The page URI that of which was archived.
      # @param options [Hash] A customizable set of options.
      # @example Return the list of available archives for a web page.
      #   Wayback.list('http://gleu.ch')
      def list(url, options={})
        object_from_response(Wayback::Archive, :get, "/timemap/link/#{url}", options)
      end

      # Return a page's information from the closest known timestamp
      #
      # @return [Wayback::Archive]
      # @param url [String] The page URI that of which was archived.
      # @param date [String, Symbol, Date, DateTime, Time, Fixnum, Integer, Float] A date or symbol to describe which dated archive page. Symbols include :first and :last. Strings are converted to integer timestamps.
      # @param options [Hash] A customizable set of options.
      # @example Return the the closest timestamp information about a page.
      #   Wayback.available('http://gleu.ch')
      def available(url, date=0, options={})
        archive_date = case date.class.to_s
          when 'Time'
            date
          when 'Date', 'DateTime'
            date.to_time
          when 'Symbol'
            (date == :first ? 19690101000000 : Time.now)
          when 'String'
            Time.parse(date).strftime('%Y%m%d%H%M%S')
          when 'Fixnum', 'Integer', 'Float'
            # Epoch vs date string as number
            (date.to_i <= Time.now.to_i ? Time.at(date.to_i) : Time.parse(date.to_i.to_s))
          else
            raise Wayback::Error::ClientError
        end

        # Format accordingly
        archive_date = archive_date.strftime('%Y%m%d%H%M%S') if archive_date.class == Time

        options[:url] = url
        options[:timestamp] = archive_date

        object_from_response(Wayback::Availability, :json_get, "/available", options)
      end

      # Returns the HTML contents of an archive page, fetched by date
      #
      # @raise [Wayback::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Wayback::Page]
      # @param url [String] The page URI that of which was archived.
      # @param date [String, Symbol, Date, DateTime, Time, Fixnum, Integer, Float] A date or symbol to describe which dated archive page. Symbols include :first and :last. Strings are converted to integer timestamps.
      # @param options [Hash] A customizable set of options.
      # @example Return the HTML archive for the page.
      #   Wayback.page('http://gleu.ch')
      #   Wayback.page('http://gleu.ch', 'Tue, 17 Jan 2012 07:33:06 GMT')
      #   Wayback.page('http://gleu.ch', '20130113125339')
      #   Wayback.page('http://gleu.ch', :first)
      #   Wayback.page('http://gleu.ch', :last)
      def page(url, date=0, options={})
        archive_date = case date.class.to_s
          when 'Time'
            date
          when 'Date', 'DateTime'
            date.to_time
          when 'Symbol'
            (date == :first ? 0 : Time.now)
          when 'String'
            Time.parse(date).strftime('%Y%m%d%H%M%S')
          when 'Fixnum', 'Integer', 'Float'
            # Epoch vs date string as number
            (date.to_i <= Time.now.to_i ? Time.at(date.to_i) : Time.parse(date.to_i.to_s))
          else
            raise Wayback::Error::ClientError
        end

        # Format accordingly
        archive_date = archive_date.strftime('%Y%m%d%H%M%S') if archive_date.class == Time

        # Get it
        object_from_response(Wayback::Page, :get, "/#{archive_date}/#{url}", options)
      end

    end
  end
end

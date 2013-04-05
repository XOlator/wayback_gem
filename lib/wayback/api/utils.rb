require 'wayback/api/arguments'

module Wayback
  module API
    module Utils

    private

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @return [Array]
      def objects_from_response(klass, request_method, path, options={})
        response = send(request_method.to_sym, path, options)[:body]
        objects_from_array(klass, response)
      end

      # @param klass [Class]
      # @param array [Array]
      # @return [Array]
      def objects_from_array(klass, array)
        array.map do |element|
          klass.fetch_or_new(element)
        end
      end

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param args [Array]
      # @return [Array]
      def threaded_object_from_response(klass, request_method, path, args)
        arguments = Wayback::API::Arguments.new(args)
        arguments.flatten.threaded_map do |id|
          object_from_response(klass, request_method, path, arguments.options.merge(:id => id))
        end
      end

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @return [Object]
      def object_from_response(klass, request_method, path, options={})
        response = send(request_method.to_sym, path, options)
        klass.from_response(response)
      end

      def handle_forbidden_error(klass, error)
        if error.message == klass::MESSAGE
          raise klass.new
        else
          raise error
        end
      end

    end
  end
end
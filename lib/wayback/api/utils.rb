module Wayback
  module API
    module Utils

    private

      # @param klass [Class]
      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @return [Object]
      def object_from_response(klass, request_method, path, options={})
        response = send(request_method.to_sym, path, options)
        klass.from_response(response)
      end

      # def handle_forbidden_error(klass, error)
      #   if error.message == klass::MESSAGE
      #     raise klass.new
      #   else
      #     raise error
      #   end
      # end

    end
  end
end

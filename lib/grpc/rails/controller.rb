module GRPC
  module Rails
    class DoubleRenderError < StandardError
      DEFAULT_MESSAGE = "Render was called multiple times in this action."

      def initialize(message = nil)
        super(message || DEFAULT_MESSAGE)
      end
    end

    class Controller
      def initialize(action:, request:, package_module:)
        @action = action
        @request = request
        @package_module = package_module
      end

      def request
        @request
      end

      def render(object)
        raise DoubleRenderError if @response_object
        @response_object = init_response_object(object)
      end

      def response
        @response_object ||= init_response_object({})
      end

      private

      def init_response_object(object)
        if object.respond_to?(:to_proto)
          object
        else
          reply_class.new(object)
        end
      end

      def reply_class
        @package_module.const_get("#{@action.to_s.camelize}Reply")
      end
    end
  end
end

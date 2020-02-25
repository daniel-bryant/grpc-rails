module GRPC
  module Rails
    class DoubleRenderError < StandardError
      DEFAULT_MESSAGE = "Render was called multiple times in this action."

      def initialize(message = nil)
        super(message || DEFAULT_MESSAGE)
      end
    end

    class Controller
      attr_accessor :action, :package_module, :response_object, :request

      def render(object)
        raise DoubleRenderError, "Can only render once per action" if response_object.present?

        self.response_object = init_response_object(object)
      end

      def response
        return response_object if response_object.present?

        reply_class.new({})
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
        package_module.const_get("#{action.to_s.camelize}Reply")
      end
    end
  end
end

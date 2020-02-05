module GRPC
  module Rails
    class Controller
      attr_reader :request

      def initialize(request)
        @request = request
      end
    end
  end
end

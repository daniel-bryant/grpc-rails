module GRPC
  module Rails
    class RouteSet
      attr_reader :services

      def initialize
        @services = []
      end

      def register(service_class)
        services << service_class
      end
    end
  end
end

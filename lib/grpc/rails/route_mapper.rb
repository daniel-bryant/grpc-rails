module GRPC
  module Rails
    class RouteMapper
      def initialize(route_set)
        @route_set = route_set
      end

      def register(service_class)
        @route_set.register(service_class)
      end
    end
  end
end

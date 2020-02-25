module GRPC
  module Rails
    class RouteMapper
      def initialize(route_set)
        @route_set = route_set
      end

      def package(package_name, &block)
        PackageMapper.new(package_name, self).instance_eval(&block)
      end

      def register(service_class)
        @route_set.register(service_class)
      end
    end
  end
end

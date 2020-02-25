module GRPC
  module Rails
    class PackageMapper
      def initialize(package_name, route_mapper)
        @package_name = package_name
        @route_mapper = route_mapper
      end

      def service(service_name, &block)
        ServiceMapper.new(@package_name, service_name, self).instance_eval(&block)
      end

      def register(service_class)
        @route_mapper.register(service_class)
      end
    end
  end
end

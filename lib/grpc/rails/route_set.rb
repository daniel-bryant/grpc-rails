module GRPC
  module Rails
    class RouteSet
      attr_reader :services

      def initialize
        @services = []
      end

      def draw(&block)
        RouteMapper.new(self).instance_eval(&block)
      end

      def register(service_class)
        services << service_class
      end
    end
  end
end

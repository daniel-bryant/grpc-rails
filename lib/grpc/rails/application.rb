module GRPC
  module Rails
    class Application
      def initialize
        @route_set = RouteSet.new
      end

      def routes
        @route_set
      end

      def services
        routes.services
      end
    end
  end
end

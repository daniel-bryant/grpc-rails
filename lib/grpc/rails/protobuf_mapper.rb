module GRPC
  module Rails
    class ProtobufMapper
      def initialize(proto_name, route_mapper)
        @proto_name = proto_name
        @route_mapper = route_mapper
      end

      def register(service_class)
        @route_mapper.register(service_class)
      end
    end
  end
end

module GRPC
  module Rails
    class ServiceMapper
      def initialize(proto_name, service_name, protobuf_mapper)
        set_proto_name(proto_name)
        set_service_name(service_name)
        protobuf_mapper.register(service_class)
      end

      def rpc(rpc_name)
        service_class.define_method(rpc_name) do |request, call|
          hsh = self.class.controller_class.new(request).send(__method__)
          self.class.reply_class(__method__).new(hsh)
        end
      end

      private

      def set_proto_name(proto_name)
        @proto_module = proto_name.to_s.camelize.constantize
      end

      def set_service_name(service_name)
        @service_camelized = service_name.to_s.camelize
        @controller_class = "#{@service_camelized}Controller".constantize
        @super_class = @proto_module.const_get(@service_camelized).const_get(:Service)
      end

      def service_class
        @service_class ||= Class.new(@super_class).tap do |klass|
          klass.extend(GRPC::Rails::Service)
          Object.const_set("#{@service_camelized}ServiceImpl", klass)
          klass.controller_class = @controller_class
          klass.proto_module = @proto_module
        end
      end
    end
  end
end

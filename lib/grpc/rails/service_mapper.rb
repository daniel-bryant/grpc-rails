module GRPC
  module Rails
    class ServiceMapper
      def initialize(package_name, service_name, package_mapper)
        set_package_name(package_name)
        set_service_name(service_name)
        package_mapper.register(service_class)
      end

      def rpc(rpc_name)
        service_class.define_method(rpc_name) do |request, call|
          self.class.log_request(self.class.controller_class.name, __method__) do
            controller = self.class.controller_class.new
            controller.request = request

            self.class.reply_class(__method__).new(controller.send(__method__))
          end
        end
      end

      private

      def set_package_name(package_name)
        @package_module = package_name.to_s.camelize.constantize
      end

      def set_service_name(service_name)
        @service_camelized = service_name.to_s.camelize
        @controller_class = "#{@service_camelized}Controller".constantize
        @super_class = @package_module.const_get(@service_camelized).const_get(:Service)
      end

      def service_class
        @service_class ||= Class.new(@super_class).tap do |klass|
          klass.extend(GRPC::Rails::Service)
          Object.const_set("#{@service_camelized}ServiceImpl", klass)
          klass.controller_class = @controller_class
          klass.package_module = @package_module
        end
      end
    end
  end
end

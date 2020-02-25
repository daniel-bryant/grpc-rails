module GRPC
  module Rails
    module Service
      attr_accessor :controller_class, :package_module

      def reply_class(method_name)
        package_module.const_get("#{method_name.to_s.camelize}Reply")
      end
    end
  end
end

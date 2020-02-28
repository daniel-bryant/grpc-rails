module GRPC
  module Rails
    module Service
      attr_accessor :controller_class, :package_module

      def reply_class(method_name)
        package_module.const_get("#{method_name.to_s.camelize}Reply")
      end

      def log_request(controller_name, action_name)
        start = Time.now
        GRPC::Rails.logger.info "Started #{controller_name}##{action_name} at #{start}"
        retval = yield
        GRPC::Rails.logger.info "Completed in #{(Time.now - start).in_milliseconds}ms"
        retval
      end
    end
  end
end

module GRPC
  module Rails
    module Service
      attr_accessor :controller_class, :package_module

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

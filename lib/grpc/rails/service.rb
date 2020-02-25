module GRPC
  module Rails
    module Service
      attr_accessor :controller_class, :package_module, :service_name

      def log_request(action_name)
        start = Time.now
        GRPC::Rails.logger.info "Started #{service_name.inspect} #{action_name.inspect} at #{start}"
        yield
        GRPC::Rails.logger.info "Completed in #{(Time.now - start).in_milliseconds}ms"
      end
    end
  end
end

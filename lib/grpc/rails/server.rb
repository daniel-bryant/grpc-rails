module GRPC
  module Rails
    class Server
      attr_reader :app

      def initialize(app)
        @app = app
      end

      def run
        GRPC::RpcServer.new.tap do |server|
          port = ENV.fetch('GRPC_PORT') { 50051 }
          addr = "0.0.0.0:#{port}"
          server.add_http2_port(addr, :this_port_is_insecure)
          puts "Listening on #{addr}"
          puts "Use Ctrl-C to stop"
          app.services.each { |s| server.handle(s) }
          # Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers
          # to gracefully shutdown.
          # Another option is run_till_terminated
          server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
        end
      end
    end
  end
end

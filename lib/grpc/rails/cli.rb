require "thor"
require "rails"
require "grpc/rails"

module GRPC
  module Rails
    class CLI < Thor
      desc "server", "Starts the grpc server"
      def server
        unless File.exist?("./config/application.rb")
          STDERR.puts "The server must be run from a Rails directory."
          exit(1)
        end

        require File.expand_path("./config/environment.rb")
        require File.expand_path("./config/grpc_routes.rb")
        GRPC::Rails::Server.new(GRPC::Rails.application).run
      end
    end
  end
end

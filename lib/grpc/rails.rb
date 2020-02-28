require "grpc"
require "grpc/rails/application"
require "grpc/rails/controller"
require "grpc/rails/package_mapper"
require "grpc/rails/railtie"
require "grpc/rails/route_mapper"
require "grpc/rails/route_set"
require "grpc/rails/server"
require "grpc/rails/service"
require "grpc/rails/service_mapper"

module GRPC
  module Rails
    def self.application
      @application ||= Application.new
    end

    def self.logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end

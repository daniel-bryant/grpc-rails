require 'test_helper'

class GRPC::Rails::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, GRPC::Rails
  end

  test "grpc gem dependency" do
    assert_kind_of Class, GRPC::RpcServer
  end

  test ".application" do
    assert_instance_of GRPC::Rails::Application, GRPC::Rails.application
  end

  test "integration" do
    GRPC::Rails.application.routes.draw do
      package :helloworld do
        service :greeter do
          rpc :hello
        end
      end
    end

    assert_equal 1, GRPC::Rails.application.services.length
    greeter = GRPC::Rails.application.services.first.new

    reply = greeter.hello(Helloworld::HelloRequest.new(name: "Daniel"), {})
    assert_equal "Hello Daniel!", reply.message

    assert Object.constants.include?(:GreeterServiceImpl)
    Object.send(:remove_const, :GreeterServiceImpl)
  end
end

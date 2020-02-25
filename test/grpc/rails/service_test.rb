require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, GRPC::Rails::Service
  end

  test "#controller_class" do
    klass = Class.new
    klass.extend(GRPC::Rails::Service)
    klass.controller_class = GreeterController
    assert_equal GreeterController, klass.controller_class
  end

  test "#package_module" do
    klass = Class.new
    klass.extend(GRPC::Rails::Service)
    klass.package_module = Helloworld
    assert_equal Helloworld, klass.package_module
  end

  test "#reply_class" do
    klass = Class.new
    klass.extend(GRPC::Rails::Service)
    klass.package_module = Helloworld
    assert_equal Helloworld::HelloReply, klass.reply_class(:hello)
  end
end

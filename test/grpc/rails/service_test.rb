require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, GRPC::Rails::Service
  end

  test "attr_accessor :controller_class" do
    klass = Class.new
    klass.extend(GRPC::Rails::Service)
    klass.controller_class = GreeterController
    assert_equal GreeterController, klass.controller_class
  end

  test "attr_accessor :package_module" do
    klass = Class.new
    klass.extend(GRPC::Rails::Service)
    klass.package_module = Helloworld
    assert_equal Helloworld, klass.package_module
  end

  test "attr_accessor :service_name" do
    klass = Class.new
    klass.extend(GRPC::Rails::Service)
    klass.package_module = :myservice
    assert_equal :myservice, klass.package_module
  end

  test "#log_request" do
    klass = Class.new
    klass.extend(GRPC::Rails::Service)
    klass.service_name = :myservice

    out, err = capture_subprocess_io do
      klass.log_request(:myaction) {}
    end

    assert_match %r%Started :myservice :myaction at%, out
    assert_match %r%Completed in%, out
    assert_equal "", err
  end
end

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

  test "#log_request" do
    klass = Class.new
    klass.extend(GRPC::Rails::Service)

    out, err = capture_subprocess_io do
      retval = klass.log_request('Foo', 'bar') { 'logged request' }
      assert_equal "logged request", retval
    end

    assert_match %r%Started Foo#bar at%, out
    assert_match %r%Completed in%, out
    assert_equal "", err
  end
end

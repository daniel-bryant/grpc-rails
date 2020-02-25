require 'test_helper'

class ControllerTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::Controller
  end

  test "attr_accessor :action" do
    controller = GRPC::Rails::Controller.new
    controller.action = "action object"
    assert_equal "action object", controller.action
  end

  test "attr_accessor :package_module" do
    controller = GRPC::Rails::Controller.new
    controller.package_module = "package_module object"
    assert_equal "package_module object", controller.package_module
  end

  test "attr_accessor :response_object" do
    controller = GRPC::Rails::Controller.new
    controller.response_object = "response_object object"
    assert_equal "response_object object", controller.response_object
  end

  test "attr_accessor :request" do
    controller = GRPC::Rails::Controller.new
    controller.request = "request object"
    assert_equal "request object", controller.request
  end

  test "#render" do
    reply_class = Class.new do
      attr_reader :params
      def initialize(params)
        @params = params
      end
    end

    package_module = Module.new
    package_module.const_set("SayHelloReply", reply_class)

    params = { foo: 'bar' }
    controller = GRPC::Rails::Controller.new
    controller.package_module = package_module
    controller.action = :say_hello
    controller.render(params)

    assert_instance_of reply_class, controller.response_object
    assert_equal params, controller.response_object.params

    assert_raise(GRPC::Rails::DoubleRenderError) { controller.render(params) }

    controller.response_object = nil

    idl_class = Class.new do
      def to_proto
      end
    end

    idl_instance = idl_class.new
    controller.render(idl_instance)
    assert_equal idl_instance, controller.response_object
  end

  test "#response" do
    reply_class = Class.new do
      attr_reader :params
      def initialize(params)
        @params = params
      end
    end

    package_module = Module.new
    package_module.const_set("SayHelloReply", reply_class)

    controller = GRPC::Rails::Controller.new
    controller.package_module = package_module
    controller.action = :say_hello

    params = {}
    resp = controller.response
    assert_instance_of reply_class, resp
    assert_equal params, resp.params

    resp_object = "my object"
    controller.response_object = resp_object
    assert_equal resp_object, controller.response
  end
end

require 'test_helper'

class ControllerTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::Controller
  end

  test "#request" do
    controller = GRPC::Rails::Controller.new(
      action: :myaction,
      request: :myrequest,
      package_module: Module.new,
    )

    assert_equal :myrequest, controller.request
  end

  test "calling #render with a hash sets #response value to an instance of the reply class" do
    reply_class = Class.new do
      attr_reader :params

      def initialize(params)
        @params = params
      end

      def to_proto; end
    end

    package_module = Module.new
    package_module.const_set('MyactionReply', reply_class)

    controller = GRPC::Rails::Controller.new(
      action: :myaction,
      request: :myrequest,
      package_module: package_module,
    )

    controller.render({foo: 'bar'})
    assert_instance_of reply_class, controller.response
    assert_equal({foo: 'bar'}, controller.response.params)
  end

  test "calling #render with an idl object sets #response value" do
    idl_class = Class.new { def to_proto; end }
    controller = GRPC::Rails::Controller.new(
      action: :myaction,
      request: :myrequest,
      package_module: Module.new,
    )

    idl_message = idl_class.new
    controller.render idl_message
    assert_equal idl_message, controller.response
  end

  test "calling #render twice raises a DoubleRenderError" do
    idl_class = Class.new { def to_proto; end }
    controller = GRPC::Rails::Controller.new(
      action: :myaction,
      request: :myrequest,
      package_module: Module.new,
    )

    controller.render(idl_class.new)
    assert_raise(GRPC::Rails::DoubleRenderError) { controller.render(idl_class.new) }
  end
end

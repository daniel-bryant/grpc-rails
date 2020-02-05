require 'test_helper'

class ControllerTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::Controller
  end

  test "#request=" do
    controller = GRPC::Rails::Controller.new
    controller.request = "request object"
    assert_equal "request object", controller.instance_variable_get(:@request)
  end

  test "#request" do
    controller = GRPC::Rails::Controller.new
    controller.instance_variable_set(:@request, "request object")
    assert_equal "request object", controller.request
  end
end

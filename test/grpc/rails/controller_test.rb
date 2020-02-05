require 'test_helper'

class ControllerTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::Controller
  end

  test "#request" do
    controller = GRPC::Rails::Controller.new(:request_object)
    assert_equal :request_object, controller.request
  end
end

require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::Application
  end

  test "#routes" do
    assert_instance_of GRPC::Rails::RouteSet, GRPC::Rails::Application.new.routes
  end

  test "#services" do
    test_class = Class.new
    app = GRPC::Rails::Application.new
    app.routes.services << test_class
    assert_equal [test_class], app.services
  end
end

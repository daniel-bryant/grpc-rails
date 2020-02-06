require 'test_helper'

class RouteSetTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::RouteSet
  end

  test "#services" do
    assert_equal [], GRPC::Rails::RouteSet.new.services
  end

  test "#draw" do
    instance = GRPC::Rails::RouteSet.new.draw { self }
    assert_instance_of GRPC::Rails::RouteMapper, instance
  end

  test "#register" do
    test_class = Class.new
    route_set = GRPC::Rails::RouteSet.new
    assert_equal [], route_set.services
    route_set.register(test_class)
    assert_equal [test_class], route_set.services
  end
end

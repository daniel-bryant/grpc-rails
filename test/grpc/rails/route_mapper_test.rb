require 'test_helper'

class RouteMapperTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::RouteMapper
  end

  test "#package" do
    route_mapper = GRPC::Rails::RouteMapper.new(TestRegistry.new([]))
    instance = route_mapper.package("helloworld") { self }
    assert_instance_of GRPC::Rails::PackageMapper, instance
  end

  test "#register" do
    route_set = TestRegistry.new([])
    route_mapper = GRPC::Rails::RouteMapper.new(route_set)
    route_mapper.register("my-service")
    assert_equal ["my-service"], route_set.objects
  end
end

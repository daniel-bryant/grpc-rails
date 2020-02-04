require 'test_helper'

class RouteMapperTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::RouteMapper
  end

  test "#register" do
    route_set = TestRegistry.new([])
    route_mapper = GRPC::Rails::RouteMapper.new(route_set)
    route_mapper.register("my-service")
    assert_equal ["my-service"], route_set.objects
  end
end

require 'test_helper'

class ProtobufMapperTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::ProtobufMapper
  end

  test "#register" do
    route_mapper = TestRegistry.new([])
    protobuf_mapper = GRPC::Rails::ProtobufMapper.new("myproto", route_mapper)
    protobuf_mapper.register("my-service")
    assert_equal ["my-service"], route_mapper.objects
  end
end

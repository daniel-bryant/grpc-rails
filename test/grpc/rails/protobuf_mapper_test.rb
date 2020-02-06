require 'test_helper'

class ProtobufMapperTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::ProtobufMapper
  end

  test "#service" do
    protobuf_mapper = GRPC::Rails::ProtobufMapper
      .new("helloworld", TestRegistry.new([]))
    instance = protobuf_mapper.service("greeter") { self }
    assert_instance_of GRPC::Rails::ServiceMapper, instance
  end

  test "#register" do
    route_mapper = TestRegistry.new([])
    protobuf_mapper = GRPC::Rails::ProtobufMapper.new("myproto", route_mapper)
    protobuf_mapper.register("my-service")
    assert_equal ["my-service"], route_mapper.objects
  end
end

require 'test_helper'

class PackageMapperTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::PackageMapper
  end

  test "#service" do
    package_mapper = GRPC::Rails::PackageMapper
      .new("helloworld", TestRegistry.new([]))
    instance = package_mapper.service("greeter") { self }
    assert_instance_of GRPC::Rails::ServiceMapper, instance

    assert Object.constants.include?(:GreeterServiceImpl)
    Object.send(:remove_const, :GreeterServiceImpl)
  end

  test "#register" do
    route_mapper = TestRegistry.new([])
    package_mapper = GRPC::Rails::PackageMapper.new("mypackage", route_mapper)
    package_mapper.register("my-service")
    assert_equal ["my-service"], route_mapper.objects
  end
end

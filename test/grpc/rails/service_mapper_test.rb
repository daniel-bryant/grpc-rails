require 'test_helper'

class ServiceMapperTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::ServiceMapper
  end

  test "#initialize" do
    package_mapper = TestRegistry.new([])
    service_mapper = GRPC::Rails::ServiceMapper
      .new("helloworld", "greeter", package_mapper)
    service_class = package_mapper.objects.first

    assert_equal GreeterServiceImpl, service_class
    assert_equal Helloworld::Greeter::Service, service_class.superclass

    assert Object.constants.include?(:GreeterServiceImpl)
    Object.send(:remove_const, :GreeterServiceImpl)
  end

  test "#rpc" do
    package_mapper = TestRegistry.new([])
    service_mapper = GRPC::Rails::ServiceMapper
      .new("helloworld", "greeter", package_mapper)
    service_class = package_mapper.objects.first

    service_mapper.rpc(:hello)
    request = Helloworld::HelloRequest.new(name: "Daniel")
    response = service_class.new.hello(request, {})
    assert_instance_of Helloworld::HelloReply, response
    assert_equal "Hello Daniel!", response.message

    assert Object.constants.include?(:GreeterServiceImpl)
    Object.send(:remove_const, :GreeterServiceImpl)
  end
end

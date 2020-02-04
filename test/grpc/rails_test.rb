require 'test_helper'

class GRPC::Rails::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, GRPC::Rails
  end

  test "grpc gem dependency" do
    assert_kind_of Class, GRPC::RpcServer
  end
end

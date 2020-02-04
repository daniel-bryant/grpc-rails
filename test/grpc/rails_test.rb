require 'test_helper'

class GRPC::Rails::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, GRPC::Rails
  end
end

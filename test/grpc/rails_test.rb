require 'test_helper'

class Grpc::Rails::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Grpc::Rails
  end
end

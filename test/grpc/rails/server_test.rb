require 'test_helper'

class ServerTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Class, GRPC::Rails::Server
  end

  test "#run" do
    # https://github.com/grpc/grpc/blob/master/examples/ruby/greeter_server.rb
    # GreeterServer is simple server that implements the Helloworld Greeter server.
    GreeterServer = Class.new(Helloworld::Greeter::Service) do
      # hello implements the Hello rpc method
      def hello(hello_req, _unused_call)
        Helloworld::HelloReply.new(message: "Hello #{hello_req.name}")
      end
    end

    App = Struct.new("App", :services)
    app = App.new([GreeterServer])

    pid = Process.fork do
      out, err = capture_io { GRPC::Rails::Server.new(app).run }
      assert_match %r%Listening on 0.0.0.0:50051%, out
      assert_match %r%Use Ctrl-C to stop%, out
      assert_equal "", err
    end

    sleep(0.1) # give just enough time for the server to start
    Process.kill("SIGQUIT", pid)
    Process.wait(pid)
  end
end

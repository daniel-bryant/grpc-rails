class GreeterController < GRPC::Rails::Controller
  def hello
    render message: "Hello #{request.name}!"
  end
end

TestRegistry = Struct.new(:objects) do
  def register(object)
    objects << object
  end
end

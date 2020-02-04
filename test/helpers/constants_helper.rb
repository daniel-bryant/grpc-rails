TestRegistry = Struct.new(:objects) do
  def register(object)
    objects << object
  end
end

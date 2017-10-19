require_relative './automated_init'

context "Condition" do
  stream_name = Controls::StreamName.example

  condition = 'position = 0'

  consumer = Controls::Consumer::Example.build(stream_name, condition: condition)

  context "Get Dependency" do
    get = consumer.get

    get_condition = get.condition

    test "Condition is configured" do
      assert(get_condition == condition)
    end
  end
end

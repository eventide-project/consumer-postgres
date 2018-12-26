require_relative '../automated_init'

context "Condition" do
  context "Get Dependency" do
    stream_name = Controls::StreamName.example

    condition = 'position = 0'

    consumer = Controls::Consumer::Example.build(stream_name, condition: condition)

    get = consumer.get

    get_condition = get.condition

    test "Receives condition" do
      assert(get_condition == condition)
    end
  end
end

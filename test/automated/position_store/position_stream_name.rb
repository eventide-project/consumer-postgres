require_relative '../automated_init'

context "Position Store" do
  context "Position Stream Name" do
    category = Controls::Category.example

    consumer = Controls::Consumer::Identifier.build(category)

    position_store = consumer.position_store

    identifier = Controls::Identifier.example
    control_stream_name = "#{category}:position-#{identifier}"

    test "Identifier is appended" do
      assert(position_store.stream_name == control_stream_name)
    end
  end
end

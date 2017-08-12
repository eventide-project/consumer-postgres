require_relative './automated_init'

context "Identifier" do
  category = Controls::Category.example

  consumer = Controls::Consumer::Identifier.build(category)

  context "Position store" do
    position_store = consumer.position_store

    test "Stream name" do
      identifier = Controls::Identifier.example
      control_stream_name = "#{category}:position-#{identifier}"

      assert(position_store.stream_name == control_stream_name)
    end
  end
end

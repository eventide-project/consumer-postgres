require_relative '../automated_init'

context "Position Store" do
  context "Location" do
    stream_name = Controls::StreamName::Position.example

    position_store = Consumer::Postgres::PositionStore.new(stream_name)

    test "Is the position stream name" do
      assert(position_store.stream_name == stream_name)
    end
  end
end

require_relative '../automated_init'

context "Position Store" do
  context "Put" do
    category = Controls::Category.example

    position = Controls::Position.example

    position_store = Consumer::Postgres::PositionStore.build(category)
    position_store.put(position)

    test "Position is written to consumer stream" do
      position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(category)

      message_data = MessageStore::Postgres::Get::Stream::Last.(position_stream_name)

      read_position = message_data.data[:position]

      assert(read_position == position)
    end
  end
end

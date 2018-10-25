require_relative '../automated_init'

context "Consumer Stream Position Store, Put Operation" do
  stream_name = Controls::StreamName.example

  position = Controls::Position.example

  position_store = Consumer::Postgres::PositionStore.build(stream_name)
  position_store.put(position)

  test "Position is written to consumer stream" do
    position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(stream_name)

    message_data = MessageStore::Postgres::Get::Last.(position_stream_name)

    read_position = message_data.data[:position]

    assert(read_position == position)
  end
end

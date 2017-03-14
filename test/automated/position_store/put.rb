require_relative '../automated_init'

context "Consumer Stream Position Store, Put Operation" do
  stream_name = Controls::StreamName.example

  position = Controls::Position.example

  position_store = Consumer::Postgres::PositionStore.build stream_name
  position_store.put position

  test "Position is written to consumer stream" do
    position_stream_name = Consumer::Postgres::PositionStore::StreamName.get stream_name

    event_data = EventSource::Postgres::Get::Last.(position_stream_name)

    read_position = event_data.data[:position]

    assert read_position == position
  end
end

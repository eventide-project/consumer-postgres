require_relative '../automated_init'

context "Consumer Stream Position Store, Get Operation" do
  context "Previous position is not recorded" do
    category = Controls::Category.example

    position_store = Consumer::Postgres::PositionStore.build(category)
    position = position_store.get

    test "No stream is returned" do
      assert(position == nil)
    end
  end

  context "Previous position is recorded" do
    position = Controls::Position.example

    stream_name = Controls::Position::Stream::Write.(position: position)

    context do
      position_store = Consumer::Postgres::PositionStore.build(stream_name)
      read_position = position_store.get

      test "Recorded position is returned" do
        assert(read_position == position)
      end
    end

    context "Consumer stream has been updated more than once" do
      next_position = position + 1

      Controls::Position::Stream::Write.(stream_name, position: next_position)

      position_store = Consumer::Postgres::PositionStore.build(stream_name)
      position = position_store.get

      test "Position of most recent update is returned" do
        assert(position == next_position)
      end
    end
  end
end

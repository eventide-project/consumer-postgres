require_relative '../automated_init'

context "Position Store" do
  context "Stream Name" do
    stream_id = Controls::ID.example

    context "Stream" do
      stream_name = Controls::StreamName.example(id: stream_id, randomize_category: false)

      position_store_stream_name = Consumer::Postgres::PositionStore::StreamName.get(stream_name)

      test do
        control_stream_name = Controls::StreamName::Position.example(
          id: stream_id,
          randomize_category: false
        )

        assert(position_store_stream_name == control_stream_name)
      end
    end

    context "Category" do
      stream_name = Controls::Category.example

      position_store_stream_name = Consumer::Postgres::PositionStore::StreamName.get(stream_name)

      test do
        control_stream_name = Controls::StreamName::Position::Category.example(category: stream_name)

        assert(position_store_stream_name == control_stream_name)
      end
    end

    context "Stream name already includes position type" do
      stream_name = Controls::StreamName::Position.example

      position_store_stream_name = Consumer::Postgres::PositionStore::StreamName.get(stream_name)

      test do
        assert(position_store_stream_name == stream_name)
      end
    end

    context "Consumer identifier given" do
      context "Category" do
        stream_name = 'someCategory'
        identifier = 'someIdentifier'

        position_stream_name = Consumer::Postgres::PositionStore::StreamName.get(stream_name, consumer_identifier: identifier)

        test "Appends identifier" do
          assert(position_stream_name == 'someCategory:position-someIdentifier')
        end
      end

      context "Stream" do
        stream_name = 'someStream-1'
        identifier = 'someIdentifier'

        position_stream_name = Consumer::Postgres::PositionStore::StreamName.get(stream_name, consumer_identifier: identifier)

        test "Appends identifier" do
          assert(position_stream_name == 'someStream:position-1-someIdentifier')
        end
      end
    end

    context "Stream name contains other types" do
      other_type = 'someType'

      stream_name = Controls::StreamName.example(id: stream_id, randomize_category: false, type: other_type)

      position_store_stream_name = Consumer::Postgres::PositionStore::StreamName.get(stream_name)

      test do
        control_stream_name = Controls::StreamName::Position.example(
          id: stream_id,
          randomize_category: false,
          types: [other_type]
        )

        assert(position_store_stream_name == control_stream_name)
      end
    end
  end
end

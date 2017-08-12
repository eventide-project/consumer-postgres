require_relative '../automated_init'

context "Position Store" do
  context "Optional Identifier" do
    context "Identifier Is Given" do
      identifier = Controls::Identifier.example

      context "Category Consumer" do
        stream_name = Controls::Category.example

        position_store = Consumer::Postgres::PositionStore.build(
          stream_name,
          consumer_identifier: identifier
        )

        test "Stream name" do
          stream_name = "#{stream_name}:position-#{identifier}"

          assert(position_store.stream_name == stream_name)
        end
      end

      context "Single Stream Consumer" do
        stream_name = Controls::StreamName.example

        position_store = Consumer::Postgres::PositionStore.build(
          stream_name,
          consumer_identifier: identifier
        )

        test "Stream name" do
          category = Messaging::StreamName.get_category(stream_name)
          stream_id = Messaging::StreamName.get_id(stream_name)

          stream_name = "#{category}:position-#{stream_id}-#{identifier}"

          assert(position_store.stream_name == stream_name)
        end
      end
    end

    context "Identifier Not Given" do
      context "Category Consumer" do
        stream_name = Controls::Category.example

        position_store = Consumer::Postgres::PositionStore.build(stream_name)

        test "Stream name" do
          stream_name = "#{stream_name}:position"

          assert(position_store.stream_name == stream_name)
        end
      end

      context "Single Stream Consumer" do
        stream_name = Controls::StreamName.example

        position_store = Consumer::Postgres::PositionStore.build(stream_name)

        test "Stream name" do
          category = Messaging::StreamName.get_category(stream_name)
          stream_id = Messaging::StreamName.get_id(stream_name)

          stream_name = "#{category}:position-#{stream_id}"

          assert(position_store.stream_name == stream_name)
        end
      end
    end
  end
end

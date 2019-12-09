require_relative '../automated_init'

context "Position Store" do
  context "Optional Identifier" do
    context "Identifier Is Given" do
      identifier = Controls::Identifier.example

      category = Controls::Category.example

      position_store = Consumer::Postgres::PositionStore.build(
        category,
        consumer_identifier: identifier
      )

      test "Stream name" do
        position_stream_name = "#{category}:position-#{identifier}"

        assert(position_store.stream_name == position_stream_name)
      end
    end

    context "Identifier Not Given" do
      stream_name = Controls::Category.example

      position_store = Consumer::Postgres::PositionStore.build(stream_name)

      test "Stream name" do
        stream_name = "#{stream_name}:position"

        assert(position_store.stream_name == stream_name)
      end
    end
  end
end

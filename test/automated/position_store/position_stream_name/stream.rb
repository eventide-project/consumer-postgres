require_relative '../../automated_init'

context "Position Store" do
  context "Position Stream Name" do
    context "For a Consumer Reading a Stream" do
      context do
        id = Controls::ID.example
        category = Controls::Category.example

        stream_name = Controls::StreamName.example(id: id, category: category)

        position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(stream_name)

        control_stream_name = "#{category}:position-#{id}"

        test "Includes the position category type" do
          assert(position_stream_name == control_stream_name)
        end
      end

      context "Stream name already includes position type" do
        stream_name = Controls::StreamName::Position.example

        position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(stream_name)

        test "The position category type appears only once" do
          assert(position_stream_name == stream_name)
        end
      end

      context "Consumer Identifier Given" do
        stream_name = Controls::StreamName::Position.example

        identifier = 'someIdentifier'

        position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(stream_name, consumer_identifier: identifier)

        control_stream_name = "#{stream_name}-#{identifier}"

        test "Identifier is appended" do
          assert(position_stream_name == control_stream_name)
        end
      end

      context "Stream name contains additional types" do
        id = Controls::ID.example
        category = Controls::Category.example

        additional_type = 'someType'

        stream_name = Controls::StreamName.example(id: id, category: category, type: additional_type)

        position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(stream_name)

        control_stream_name = "#{category}:#{additional_type}+position-#{id}"

        test do
          assert(position_stream_name == control_stream_name)
        end
      end
    end
  end
end

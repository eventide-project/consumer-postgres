require_relative '../../automated_init'

context "Position Store" do
  context "Position Stream Name" do
    context "For a Consumer Reading a Category" do
      context do
        category = Controls::Category.example

        position_store_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(category)

        control_stream_name = "#{category}:position"

        test "Includes the position category type" do
          assert(position_store_stream_name == control_stream_name)
        end
      end

      context "Stream name already includes position type" do
        category = Controls::Category::Position.example

        position_store_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(category)

        test "The position category type appears only once" do
          assert(position_store_stream_name == category)
        end
      end

      context "Consumer Identifier Given" do
        category = Controls::Category.example

        identifier = 'someIdentifier'

        position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(category, consumer_identifier: identifier)

        control_stream_name = "#{category}:position-#{identifier}"

        test "Appends the identifier" do
          assert(position_stream_name == control_stream_name)
        end
      end

      context "Stream name contains additional types" do
        category = Controls::Category.example

        additional_type = 'someType'

        stream_name = Controls::StreamName.example(id: :none, category: category, type: additional_type)

        position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(stream_name)

        control_stream_name = "#{category}:#{additional_type}+position"

        test do
          assert(position_stream_name == control_stream_name)
        end
      end
    end
  end
end

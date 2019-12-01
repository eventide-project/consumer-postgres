require_relative '../automated_init'

context "Position Store" do
  context "Position Stream Name" do
    context do
      category = Controls::Category.example

      position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(category)

      control_stream_name = "#{category}:position"

      test "Includes the position category type" do
        assert(position_stream_name == control_stream_name)
      end
    end

    context "Category already includes position type" do
      category = Controls::Category::Position.example

      position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(category)

      test "The position category type appears only once" do
        assert(position_stream_name == category)
      end
    end

    context "Consumer Identifier Given" do
      category = Controls::Category.example

      identifier = 'someIdentifier'

      position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(category, consumer_identifier: identifier)

      control_stream_name = "#{category}:position-#{identifier}"

      test "Identifier is appended" do
        assert(position_stream_name == control_stream_name)
      end
    end

    context "Category contains additional types" do
      category = Controls::Category.example

      additional_type = 'someType'

      stream_name = Controls::Category.example(category: category, type: additional_type)

      position_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(stream_name)

      control_stream_name = "#{category}:#{additional_type}+position"

      test "Additional types are preserved" do
        assert(position_stream_name == control_stream_name)
      end
    end

    context "Stream name is given" do
      stream_name = Controls::StreamName.example

      test "Is an error" do
        assert_raises(Consumer::Postgres::PositionStore::StreamName::Error) do
          Consumer::Postgres::PositionStore::StreamName.position_stream_name(stream_name)
        end
      end
    end
  end
end

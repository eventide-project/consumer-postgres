require_relative '../automated_init'

context "Build" do
  category = Controls::Category.example
  session_settings = ::MessageStore::Postgres::Settings.instance
  correlation = Controls::Message::Metadata.correlation_stream_name
  batch_size = 1
  group_member = 0
  group_size = 1
  condition = 'position = 0'
  identifier = Controls::Identifier.example

  consumer = Controls::Consumer::Example.build(
    category,
    session_settings: session_settings,
    correlation: correlation,
    batch_size: batch_size,
    group_member: group_member,
    group_size: group_size,
    condition: condition,
    identifier: identifier
  )

  context "Get" do
    get = consumer.get

    context "Stream Name" do
      test "Is set" do
        assert(get.stream_name == category)
      end
    end

    context "Correlation" do
      test "Is set" do
        assert(get.correlation == correlation)
      end
    end

    context "Group Member" do
      test "Is set" do
        assert(get.consumer_group_member == group_member)
      end
    end

    context "Group Size" do
      test "Is set" do
        assert(get.consumer_group_size == group_size)
      end
    end

    context "Condition" do
      test "Is set" do
        assert(get.condition == condition)
      end
    end

    context "Batch Size" do
      test "Is set" do
        assert(get.batch_size == batch_size)
      end
    end

    context "Session" do
      test "Is set" do
        assert(get.session.instance_of?(consumer.session.class))
      end

      test "Assigned a different session from consumer" do
        refute(get.session.equal?(consumer.session))
      end
    end
  end

  context "Position store" do
    position_store = consumer.position_store

    test "Is configured" do
      assert(position_store.instance_of?(Consumer::Postgres::PositionStore))
    end

    context "Session" do
      test "Is set to the consumer's session" do
        assert(position_store.session.equal?(consumer.session))
      end
    end

    context "Stream name" do
      position_stream = position_store.stream_name

      test "Category" do
        compare_category = MessageStore::StreamName.get_category(position_stream)

        assert(compare_category == "#{category}:position")
      end

      test "ID" do
        id = MessageStore::StreamName.get_id(position_stream)

        assert(id == identifier)
      end
    end
  end
end

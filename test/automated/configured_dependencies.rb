require_relative 'automated_init'

context "Configuration" do
  stream_name = Controls::Category.example

  correlation = 'someCorrelation'
  condition = 'position = 0'
  group_member = 0
  group_size = 1

  batch_size = 11
  poll_interval_milliseconds = 1111

  settings = MessageStore::Postgres::Settings.instance

  consumer = Controls::Consumer::Example.build(
    stream_name,
    correlation: correlation,
    group_member: group_member,
    group_size: group_size,
    condition: condition,
    batch_size: batch_size,
    poll_interval_milliseconds: poll_interval_milliseconds,
    settings: settings
  )

  context "Get" do
    get = consumer.get

    context "Stream Name" do
      test "Is set" do
        assert(get.stream_name == stream_name)
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
      test "Category" do
        control_category = MessageStore::StreamName.get_category(stream_name)
        category = MessageStore::StreamName.get_category(position_store.stream_name)

        assert(category == "#{control_category}:position")
      end

      test "ID" do
        control_id = MessageStore::StreamName.get_id(stream_name)
        id = MessageStore::StreamName.get_id(position_store.stream_name)

        assert(id == control_id)
      end
    end
  end
end

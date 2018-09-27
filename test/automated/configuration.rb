require_relative './automated_init'

context "Configuration" do
  batch_size = 11
  poll_interval_milliseconds = 1111

  stream_name = Controls::StreamName.example

  settings = MessageStore::Postgres::Settings.instance

  consumer = Controls::Consumer::Example.build(
    stream_name,
    batch_size: batch_size,
    poll_interval_milliseconds: poll_interval_milliseconds,
    settings: settings
  )

  context "Get" do
    get = consumer.get

    context "Batch size" do
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
      test "Is set to that of consumer" do
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

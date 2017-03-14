require_relative './automated_init'

context "Configuration" do
  batch_size = 11
  cycle_timeout_milliseconds = 1111

  stream_name = Controls::StreamName.example

  session = EventSource::Postgres::Session.build

  consumer = Controls::Consumer::Example.build(
    stream_name,
    batch_size: batch_size,
    cycle_timeout_milliseconds: cycle_timeout_milliseconds,
    session: session
  )

  context "Get" do
    get = consumer.get

    context "Batch size" do
      test "Is set" do
        assert get.batch_size == batch_size
      end
    end

    context "Session" do
      test "Is set" do
        assert get.session.equal?(session)
      end
    end
  end

  context "Position store" do
    position_store = consumer.position_store

    test "Is configured" do
      assert position_store.instance_of?(Consumer::Postgres::PositionStore)
    end

    context "Session" do
      test "Is set" do
        assert position_store.session.equal?(session)
      end
    end

    context "Stream name" do
      test "Category" do
        control_category = EventSource::Postgres::StreamName.get_category stream_name
        category = EventSource::Postgres::StreamName.get_category position_store.stream_name

        assert category == "#{control_category}:position"
      end

      test "ID" do
        control_id = EventSource::Postgres::StreamName.get_id stream_name
        id = EventSource::Postgres::StreamName.get_id position_store.stream_name

        assert id == control_id
      end
    end
  end
end

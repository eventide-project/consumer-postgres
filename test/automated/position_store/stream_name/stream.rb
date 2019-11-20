require_relative '../../automated_init'

context "Position Store" do
  context "Stream Name" do
    stream_id = Controls::ID.example

    category = 'test'

    context "Stream" do
      # stream_name = Controls::StreamName.example(id: stream_id, randomize_category: false)
      # stream_name = Controls::StreamName.example(id: stream_id, randomize_category: true)
      stream_name = Controls::StreamName.example(id: stream_id, category: category)

      position_store_stream_name = Consumer::Postgres::PositionStore::StreamName.position_stream_name(stream_name)

      test do
        # control_stream_name = Controls::StreamName::Position.example(
        #   id: stream_id,
        #   randomize_category: false
        # )
        # control_stream_name = Controls::StreamName::Position.example(
        #   id: stream_id,
        #   randomize_category: true
        # )
        control_stream_name = Controls::StreamName::Position.example(
          id: stream_id,
          category: category
        )



pp control_stream_name
pp position_store_stream_name

        assert(position_store_stream_name == control_stream_name)
      end
    end
  end
end


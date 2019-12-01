require_relative 'automated_init'

context "Stream Error" do
  context "Consumed Stream is a Stream Rather than a Category" do
    stream_name = Controls::StreamName.example

    test "Is an error" do
      assert_raises Consumer::Postgres::Error do
        Controls::Consumer::Example.start(stream_name)
      end
    end
  end
end

require_relative '../automated_init'

context "Condition" do
  context "Get" do
    stream_name = Controls::StreamName.example

    correlation = 'someCorrelation'
    condition = 'position = 0'

    consumer = Controls::Consumer::Example.build(stream_name, correlation: correlation, condition: condition)

    get = consumer.get

    get_correlation = get.correlation
    get_condition = get.condition

    test "Receives correlation" do
      assert(get_correlation == correlation)
    end

    test "Receives condition" do
      assert(get_condition == condition)
    end
  end
end

require_relative 'automated_init'

context "Consumer's Get Dependency" do
  stream_name = Controls::Category.example

  correlation = 'someCorrelation'
  condition = 'position = 0'
  group_member = 0
  group_size = 1

  consumer = Controls::Consumer::Example.build(stream_name, correlation: correlation, group_member: group_member, group_size: group_size, condition: condition)

  get = consumer.get

  test "Receives correlation" do
    assert(get.correlation == correlation)
  end

  test "Receives group member" do
    assert(get.consumer_group_member == group_member)
  end

  test "Receives group size" do
    assert(get.consumer_group_size == group_size)
  end

  test "Receives condition" do
    assert(get.condition == condition)
  end
end

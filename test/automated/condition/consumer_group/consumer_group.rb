require_relative '../../automated_init'

context "Condition" do
  context "Consumer Group" do
    context "Specified" do
      group_size = 2
      group_member = 0

      control_condition = Controls::Condition::ConsumerGroup.example(group_size: group_size, group_member: group_member)

      composed_condition = Consumer::Postgres::Condition.compose(group_size: group_size, group_member: group_member)

      test "Is a query condition matching the consumer group parameters" do
        assert(composed_condition == control_condition)
      end
    end

    context "Not Specified" do
      composed_condition = Consumer::Postgres::Condition.compose(group_size: nil, group_member: nil)

      test "Is nil" do
        assert(composed_condition.nil?)
      end
    end
  end
end

require_relative '../../automated_init'

context "Condition" do
  context "Consumer Group" do
    context "Composed with Condition" do
      context "Specified" do
        condition = Controls::Condition::Ordinary.example

        group_size = 2
        group_member = 0

        control_consumer_group_condition = Controls::Condition::ConsumerGroup.example(group_size: group_size, group_member: group_member)

        control_condition = "#{condition} AND #{control_consumer_group_condition}"

        composed_condition = Consumer::Postgres::Condition.compose(group_size: group_size, group_member: group_member, condition: condition)

        test "Composed of both the correlation condition and the ordinary condition" do
          assert(composed_condition == control_condition)
        end
      end
    end
  end
end

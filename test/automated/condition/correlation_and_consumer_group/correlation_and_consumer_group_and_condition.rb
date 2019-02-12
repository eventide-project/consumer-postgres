require_relative '../../automated_init'

context "Condition" do
  context "Correlation and Consumer Group" do
    context "Composed with Condition" do
      context "Specified" do
        correlation = "someCategory"

        condition = Controls::Condition::Ordinary.example

        control_correlation_condition = Controls::Condition::Correlation.example(category: correlation)

        group_size = 2
        group_member = 0

        control_consumer_group_condition = Controls::Condition::ConsumerGroup.example(group_size: group_size, group_member: group_member)

        control_condition = "#{condition} AND #{control_correlation_condition} AND #{control_consumer_group_condition}"

        composed_condition = Consumer::Postgres::Condition.compose(correlation: correlation, group_size: group_size, group_member: group_member, condition: condition)

        test "Composed of both the correlation condition and the ordinary condition" do
          assert(composed_condition == control_condition)
        end
      end
    end
  end
end

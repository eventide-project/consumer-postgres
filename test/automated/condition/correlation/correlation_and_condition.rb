require_relative '../../automated_init'

context "Condition" do
  context "Correlation and Condition" do
    context "Specified" do
      correlation = "someCategory"
      condition = Controls::Condition::Ordinary.example

      control_correlation_condition = Controls::Condition::Correlation.example(category: correlation)

      control_condition = "#{condition} AND #{control_correlation_condition}"

      composed_condition = Consumer::Postgres::Condition.compose(correlation: correlation, condition: condition)

      test "Composed of both the correlation condition and the ordinary condition" do
        assert(composed_condition == control_condition)
      end
    end

    context "Not Specified" do
      composed_condition = Consumer::Postgres::Condition.compose()

      test "Is nil" do
        assert(composed_condition.nil?)
      end
    end
  end
end

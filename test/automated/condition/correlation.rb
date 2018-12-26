require_relative '../automated_init'

context "Condition" do
  context "Correlation" do
    context "Category" do
      correlation = "someCategory"
      condition = Consumer::Postgres.compose_condition(correlation: correlation)

      control_condition = "metadata->>'correlationStreamName' like '#{correlation}-%'"

      test "Is a JSON document query matching the correlation category" do
        assert(condition == control_condition)
      end
    end

    context "Not Specified" do
      condition = Consumer::Postgres.compose_condition()

      test "Is a JSON document query matching the correlation category" do
        assert(condition.nil?)
      end
    end
  end
end

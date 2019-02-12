require_relative '../../automated_init'

context "Condition" do
  context "Correlation" do
    context "Specified" do
      correlation = "someCategory"

      control_condition = Controls::Condition::Correlation.example(category: correlation)

      composed_condition = Consumer::Postgres::Condition.compose(correlation: correlation)

      test "Is a JSON document query condition matching the correlation category" do
        assert(composed_condition == control_condition)
      end
    end

    context "Not Specified" do
      composed_condition = Consumer::Postgres::Condition.compose(correlation: nil)

      test "Is nil" do
        assert(composed_condition.nil?)
      end
    end
  end
end

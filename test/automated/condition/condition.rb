require_relative '../automated_init'

context "Condition" do
  context "Specified" do
    condition = Controls::Condition::Ordinary.example

    composed_condition = Consumer::Postgres::Condition.compose(condition: condition)

    test "Is the specified condition" do
      assert(composed_condition == condition)
    end
  end

  context "Not Specified" do
    composed_condition = Consumer::Postgres::Condition.compose()

    test "Is nil" do
      assert(composed_condition.nil?)
    end
  end
end

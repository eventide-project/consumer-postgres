require_relative '../../automated_init'

context "Condition" do
  context "Correlation" do
    context "Not a Category" do
      correlation = "someCategory-someId"

      test "Is an error" do
        assert_raises(Consumer::Postgres::Correlation::Error) do
          Consumer::Postgres::Condition.compose(correlation: correlation)
        end
      end
    end
  end
end

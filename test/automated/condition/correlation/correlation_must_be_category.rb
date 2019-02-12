require_relative '../../automated_init'

context "Condition" do
  context "Correlation" do
    context "Not a Category" do
      correlation = "someCategory-someId"

      test "Is an error" do
        assert proc { Consumer::Postgres::Condition.compose(correlation: correlation) } do
          raises_error? Consumer::Postgres::Correlation::Error
        end
      end
    end
  end
end

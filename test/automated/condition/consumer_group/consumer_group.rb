require_relative '../../automated_init'

=begin
- need both group_size and group_member
=end

__END__
context "Condition" do
  context "Compose" do
    context "Consumer Group" do
      context "Specified" do
        correlation = "someCategory"
        control_condition = Controls::Condition::Correlation.example(category: correlation)

        composed_condition = Consumer::Postgres::Condition.compose(correlation: correlation)

        test "Is a JSON document query matching the correlation category" do
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
end

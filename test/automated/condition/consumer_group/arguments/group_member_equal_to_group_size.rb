require_relative '../../../automated_init'

context "Condition" do
  context "Consumer Group" do
    context "Arguments" do
      context "Group Member" do
        category = Consumer::Postgres::Controls::Category.example

        context "Group Member is Equal to Group Size" do
          start_consumer = proc do
            Controls::Consumer::Example.start(
              category,
              group_size: 1,
              group_member: 2
            )
          end

          test "Is an error" do
            assert start_consumer do
              raises_error? Consumer::Postgres::Error
            end
          end
        end
      end
    end
  end
end

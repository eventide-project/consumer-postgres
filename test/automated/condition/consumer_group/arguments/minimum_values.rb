require_relative '../../../automated_init'

context "Condition" do
  context "Consumer Group" do
    context "Arguments" do
      context "Minimum Values" do
        category = Consumer::Postgres::Controls::Category.example

        context "Group Member is Less than 1" do
          test "Is an error" do
            assert_raises Consumer::Postgres::Group::Error do
              Controls::Consumer::Example.start(
                category,
                group_size: 1,
                group_member: -1
              )
            end
          end
        end

        context "Group Size is Less than 1" do
          test "Is an error" do
            assert_raises Consumer::Postgres::Group::Error do
              Controls::Consumer::Example.start(
                category,
                group_size: 0,
                group_member: 0
              )
            end
          end
        end
      end
    end
  end
end

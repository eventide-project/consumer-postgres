require_relative '../../../automated_init'

context "Condition" do
  context "Consumer Group" do
    context "Arguments" do
      context "Group Member" do
        category = Consumer::Postgres::Controls::Category.example

        context "Group Member is Greater than Group Size" do
          test "Is an error" do
            assert_raises(Consumer::Postgres::Group::Error) do
              Controls::Consumer::Example.start(
                category,
                group_size: 1,
                group_member: 2
              )
            end
          end
        end
      end
    end
  end
end

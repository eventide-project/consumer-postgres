require_relative '../../../automated_init'

context "Condition" do
  context "Consumer Group" do
    context "Arguments" do
      context "Required" do
        category = Consumer::Postgres::Controls::Category.example

        context "Group Size is Specified" do
          context "Group Member is Missing" do
            start_consumer = proc do
              Controls::Consumer::Example.start(
                category,
                group_size: 1
              )
            end

            test "Is an error" do
              assert start_consumer do
                raises_error? Consumer::Postgres::Group::Error
              end
            end
          end
        end

        context "Group Member is Specified" do
          context "Group Size is Missing" do
            start_consumer = proc do
              Controls::Consumer::Example.start(
                category,
                group_member: 1
              )
            end

            test "Is an error" do
              assert start_consumer do
                raises_error? Consumer::Postgres::Group::Error
              end
            end
          end
        end
      end
    end
  end
end

require_relative 'automated_init'

context "Identifier Error" do
  context "Identifier Is Not Set and Consumer Group Is Set" do
    test "Is an error" do
      assert_raises(Consumer::Postgres::Identifier::Error) do
        Actor::Supervisor.start do
          Controls::Consumer::Example.start(
            'someCategory',
            group_member: 0,
            group_size: 1
          )
        end
      end
    end
  end

  context "Identifier Is Set and Consumer Group Is Set" do
    test "Is not an error" do
      refute_raises(Consumer::Postgres::Identifier::Error) do
          Controls::Consumer::Example.start(
            'someCategory',
            identifier: 'someIdentifier',
            group_member: 0,
            group_size: 1
          )
      end
    end
  end
end

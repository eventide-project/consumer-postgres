require_relative 'automated_init'

context "Condition Error" do
  context "Condition Is Not Activated" do
    test "Is an error" do
      assert_raises(MessageStore::Postgres::Get::Condition::Error) do
        Actor::Supervisor.start do
          Controls::Consumer::Example.start(
            'someCategory',
            condition: 'some condition'
          )
        end
      end
    end
  end
end

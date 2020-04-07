require_relative 'automated_init'

context "Consumer Group Error" do
  context "Consumer Group Size Is Less than 1" do
    test "Is an error" do
      assert_raises(MessageStore::Postgres::Get::Category::ConsumerGroup::Error) do
        Actor::Supervisor.start do
          Controls::Consumer::Example.start(
            'someCategory',
            group_member: 0,
            group_size: 0,
            identifier: 'someIdentifier'
          )
        end
      end
    end
  end

  context "Consumer Group Member Is Greater than the Consumer Group Size" do
    test "Is an error" do
      assert_raises(MessageStore::Postgres::Get::Category::ConsumerGroup::Error) do
        Actor::Supervisor.start do
          Controls::Consumer::Example.start(
            'someCategory',
            group_member: 2,
            group_size: 1,
            identifier: 'someIdentifier'
          )
        end
      end
    end
  end

  context "Consumer Group Member Is Less than 0" do
    test "Is an error" do
      assert_raises(MessageStore::Postgres::Get::Category::ConsumerGroup::Error) do
        Actor::Supervisor.start do
          Controls::Consumer::Example.start(
            'someCategory',
            group_member: -1,
            group_size: 1,
            identifier: 'someIdentifier'
          )
        end
      end
    end
  end

  context "Consumer Group Size is Missing" do
    test "Is an error" do
      assert_raises(MessageStore::Postgres::Get::Category::ConsumerGroup::Error) do
        Actor::Supervisor.start do
          Controls::Consumer::Example.start(
            'someCategory',
            group_member: 0
          )
        end
      end
    end
  end

  context "Consumer Group Member is Missing" do
    test "Is an error" do
      assert_raises(MessageStore::Postgres::Get::Category::ConsumerGroup::Error) do
        Actor::Supervisor.start do
          Controls::Consumer::Example.start(
            'someCategory',
            group_size: 1
          )
        end
      end
    end
  end
end

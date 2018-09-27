module Consumer
  module Postgres
    def self.included(cls)
      cls.class_exec do
        include ::Consumer
      end
    end

    def configure(batch_size: nil, settings: nil, condition: nil)
      MessageStore::Postgres::Session.configure(self, settings: settings)

      get_session = MessageStore::Postgres::Session.build(settings: settings)
      MessageStore::Postgres::Get.configure(
        self,
        batch_size: batch_size,
        condition: condition,
        session: get_session
      )

      PositionStore.configure(
        self,
        stream_name,
        consumer_identifier: identifier,
        session: session
      )
    end
  end
end

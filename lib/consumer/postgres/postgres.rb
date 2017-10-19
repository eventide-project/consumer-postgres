module Consumer
  module Postgres
    def self.included(cls)
      cls.class_exec do
        include ::Consumer
      end
    end

    def configure(session: nil, batch_size: nil, position_store: nil, condition: nil)
      MessageStore::Postgres::Get.configure(
        self,
        batch_size: batch_size,
        condition: condition,
        session: session
      )

      PositionStore.configure(
        self,
        stream_name,
        position_store: position_store,
        consumer_identifier: identifier,
        session: session
      )
    end
  end
end

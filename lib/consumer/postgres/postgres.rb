module Consumer
  module Postgres
    def self.included(cls)
      cls.class_exec do
        include ::Consumer
      end
    end

    def configure(session: nil, batch_size: nil, position_store: nil)
      EventSource::Postgres::Get.configure(
        self,
        session: session,
        batch_size: batch_size
      )

      PositionStore.configure(
        self,
        stream_name,
        position_store: position_store,
        session: session
      )
    end
  end
end

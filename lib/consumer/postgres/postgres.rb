module Consumer
  module Postgres
    def self.included(cls)
      cls.class_exec do
        include ::Consumer
      end
    end

    def configure(session: nil, batch_size: nil)
      EventSource::Postgres::Get.configure self, session: session, batch_size: batch_size
    end
  end
end

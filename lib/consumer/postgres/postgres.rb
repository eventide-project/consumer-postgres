module Consumer
  module Postgres
    def self.included(cls)
      cls.class_exec do
        include ::Consumer
      end
    end

    def configure
      EventSource::Postgres::Get.configure self
    end
  end
end

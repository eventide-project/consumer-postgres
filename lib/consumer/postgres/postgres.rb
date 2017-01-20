module Consumer
  module Postgres
    def self.included(cls)
      cls.class_exec do
        include ::Consumer
      end
    end
  end
end

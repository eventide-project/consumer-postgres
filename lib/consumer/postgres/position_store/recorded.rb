module Consumer
  module Postgres
    class PositionStore
      class Recorded
        include Messaging::Message

        attribute :position, Integer
      end
    end
  end
end

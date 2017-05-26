module Consumer
  module Postgres
    class PositionStore
      class Updated
        include Messaging::Message

        attribute :position, Integer
      end
    end
  end
end

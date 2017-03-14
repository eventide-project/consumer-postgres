module Consumer
  module Postgres
    module Controls
      module Position
        module Store
          module Message
            def self.example(position: nil)
              position ||= Position.example

              message = PositionStore::Messages::PositionUpdated.new
              message.position = position
              message
            end
          end
        end
      end
    end
  end
end

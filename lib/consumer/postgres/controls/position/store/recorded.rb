module Consumer
  module Postgres
    module Controls
      module Position
        module Store
          module Recorded
            def self.example(position: nil)
              position ||= Position.example

              message = PositionStore::Recorded.new
              message.position = position
              message
            end
          end
        end
      end
    end
  end
end

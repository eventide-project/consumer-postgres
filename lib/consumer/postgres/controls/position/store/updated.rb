module Consumer
  module Postgres
    module Controls
      module Position
        module Store
          module Updated
            def self.example(position: nil)
              position ||= Position.example

              message = PositionStore::Updated.new
              message.position = position
              message
            end
          end
        end
      end
    end
  end
end

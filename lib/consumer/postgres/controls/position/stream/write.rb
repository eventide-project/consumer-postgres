module Consumer
  module Postgres
    module Controls
      module Position
        module Stream
          module Write
            def self.call(stream_name=nil, position: nil)
              stream_name ||= Category::Position.example

              message = Store::Recorded.example(position: position)

              Messaging::Postgres::Write.(message, stream_name)

              stream_name
            end
          end
        end
      end
    end
  end
end

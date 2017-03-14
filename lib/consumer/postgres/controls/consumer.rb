module Consumer
  module Postgres
    module Controls
      module Consumer
        class Example
          include ::Consumer::Postgres
        end

        class Incrementing
          include ::Consumer::Postgres

          handler do |event_data|
            logger.info { "Handled event (StreamName: #{event_data.stream_name}, GlobalPosition: #{event_data.global_position})" }
            logger.debug { event_data.data.pretty_inspect }
          end
        end
      end
    end
  end
end

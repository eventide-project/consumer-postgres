module Consumer
  module Postgres
    module Controls
      module Consumer
        class Example
          include ::Consumer::Postgres
        end

        class Incrementing
          include ::Consumer::Postgres

          handler do |message_data|
            logger.info { "Handled message (StreamName: #{message_data.stream_name}, GlobalPosition: #{message_data.global_position})" }
            logger.debug { message_data.data.pretty_inspect }
          end
        end

        class Identifier
          include ::Consumer::Postgres

          identifier Controls::Identifier.example
        end
      end
    end
  end
end

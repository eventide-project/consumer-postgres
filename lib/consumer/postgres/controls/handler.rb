module Consumer
  module Postgres
    module Controls
      class Handler
        include Messaging::Handle
        include Log::Dependency

        def handle(message_data)
          logger.info "Handled message (StreamName: #{message_data.stream_name}, Correlation Stream Name: #{message_data.metadata[:correlation_stream_name]}, GlobalPosition: #{message_data.global_position})"
          logger.debug message_data.data.pretty_inspect
        end
      end
    end
  end
end

module Consumer
  module Postgres
    module Controls
      module Message
        def self.example(attribute: nil, correlation: nil)
          message = Messaging::Controls::Message.example(some_attribute: attribute)
          message.metadata.correlation_stream_name = correlation unless correlation.nil?

          message
        end
      end
    end
  end
end

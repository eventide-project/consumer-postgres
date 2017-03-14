module Consumer
  module Postgres
    class PositionStore
      include Consumer::PositionStore

      initializer :stream_name

      dependency :read, EventSource::Postgres::Get::Last
      dependency :session, EventSource::Postgres::Session
      dependency :write, ::Messaging::Postgres::Write

      def self.build(stream_name, session: nil)
        position_stream_name = StreamName.get stream_name

        instance = new position_stream_name
        EventSource::Postgres::Session.configure instance, session: session
        instance.configure
        instance
      end

      def configure
        EventSource::Postgres::Get::Last.configure(
          self,
          session: session,
          attr_name: :read
        )

        Messaging::Postgres::Write.configure self, session: session
      end

      def get
        event_data = read.(stream_name)

        return nil if event_data.nil?

        message = Messaging::Message::Import.(event_data, Messages::PositionUpdated)

        message.position
      end

      def put(position)
        message = Messages::PositionUpdated.new
        message.position = position

        write.(message, stream_name)
      end
    end
  end
end

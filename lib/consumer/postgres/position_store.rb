module Consumer
  module Postgres
    class PositionStore
      include Consumer::PositionStore

      Dependency.activate(self)

      initializer :stream_name

      dependency :read, MessageStore::Postgres::Get::Last
      dependency :session, MessageStore::Postgres::Session
      dependency :write, ::Messaging::Postgres::Write

      def self.build(stream_name, session: nil, consumer_identifier: nil)
        position_stream_name = StreamName.get(stream_name, consumer_identifier: consumer_identifier)

        instance = new position_stream_name
        MessageStore::Postgres::Session.configure(instance, session: session)
        instance.configure
        instance
      end

      def configure
        MessageStore::Postgres::Get::Last.configure(
          self,
          session: session,
          attr_name: :read
        )

        Messaging::Postgres::Write.configure(self, session: session)
      end

      def get
        message_data = read.(stream_name)

        return nil if message_data.nil?

        message = Messaging::Message::Import.(message_data, Recorded)

        message.position
      end

      def put(position)
        message = Recorded.new
        message.position = position

        write.(message, stream_name)
      end
    end
  end
end

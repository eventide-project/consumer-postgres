module Consumer
  module Postgres
    class PositionStore
      include Consumer::PositionStore

      initializer :stream_name

      dependency :read, MessageStore::Postgres::Get::Last
      dependency :session, MessageStore::Postgres::Session
      dependency :write, ::Messaging::Postgres::Write

      def self.build(stream_name, session: nil)
        position_stream_name = StreamName.get stream_name

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

        message = Messaging::Message::Import.(message_data, Updated)

        message.position
      end

      def put(position)
        message = Updated.new
        message.position = position

        write.(message, stream_name)
      end
    end
  end
end

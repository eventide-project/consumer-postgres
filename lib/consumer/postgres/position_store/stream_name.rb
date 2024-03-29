module Consumer
  module Postgres
    class PositionStore
      module StreamName
        Error = Class.new(RuntimeError)

        def self.position_stream_name(stream_name, consumer_identifier: nil)
          if not MessageStore::StreamName.category?(stream_name)
            raise Error, "Position store's stream name must be a category (Stream Name: #{stream_name})"
          end

          entity_name = MessageStore::StreamName.get_entity_name(stream_name)
          type_list = MessageStore::StreamName.get_types(stream_name)

          position_type = Type.get

          if not type_list.include?(position_type)
            type_list << position_type
          end

          stream_id = nil
          if not consumer_identifier.nil?
            stream_id = consumer_identifier
          end

          MessageStore::StreamName.stream_name(
            entity_name,
            stream_id,
            types: type_list
          )
        end

        module Type
          def self.get
            'position'
          end
        end
      end
    end
  end
end

module Consumer
  module Postgres
    class PositionStore
      module StreamName
        Error = Class.new(RuntimeError)

        def self.position_stream_name(stream_name, consumer_identifier: nil)
          if not MessageStore::StreamName.category?(stream_name)
            raise Error, "Position store's stream name must be a category (Stream Name: #{stream_name})"
          end

          stream_id = MessageStore::StreamName.get_id(stream_name)
          entity_name = MessageStore::StreamName.get_entity_name(stream_name)
          type_list = MessageStore::StreamName.get_types(stream_name)

          position_type = Type.get

          if not type_list.include?(position_type)
            type_list << position_type
          end

          if not consumer_identifier.nil?
            if stream_id.nil?
              stream_id = consumer_identifier
            else
              stream_id = "#{stream_id}-#{consumer_identifier}"
            end
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

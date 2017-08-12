module Consumer
  module Postgres
    class PositionStore
      module StreamName
        def self.get(stream_name, consumer_identifier: nil)
          stream_id = MessageStore::StreamName.get_id(stream_name)
          entity = MessageStore::StreamName.get_entity_name(stream_name)
          type_list = MessageStore::StreamName.get_types(stream_name)

          position_type = Type.get

          type_list << position_type unless type_list.include?(position_type)

          unless consumer_identifier.nil?
            if stream_id.nil?
              stream_id = consumer_identifier
            else
              stream_id = "#{stream_id}-#{consumer_identifier}"
            end
          end

          MessageStore::StreamName.stream_name(
            entity,
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

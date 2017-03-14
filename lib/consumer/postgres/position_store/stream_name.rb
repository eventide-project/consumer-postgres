module Consumer
  module Postgres
    class PositionStore
      module StreamName
        def self.get(stream_name)
          id = EventSource::Postgres::StreamName.get_id stream_name
          entity = EventSource::Postgres::StreamName.get_entity_name stream_name
          type_list = EventSource::Postgres::StreamName.get_types stream_name

          position_type = Type.get

          type_list << position_type unless type_list.include? position_type

          EventSource::Postgres::StreamName.stream_name(
            entity,
            id,
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

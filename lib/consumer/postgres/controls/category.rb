module Consumer
  module Postgres
    module Controls
      Category = MessageStore::Postgres::Controls::Category

      module Category
        module Position
          def self.example
            category = Controls::Category.example

            type = 'position'

            MessageStore::StreamName.stream_name(category, type: type)
          end
        end
      end
    end
  end
end

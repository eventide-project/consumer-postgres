module Consumer
  module Postgres
    module Controls
      Category = MessageStore::Postgres::Controls::Category

      module Category
        module Position
          def self.example
            category ||= Controls::Category.example(category: category)

            types = ['position']

            MessageStore::StreamName.stream_name(category, types: types)
          end
        end
      end
    end
  end
end

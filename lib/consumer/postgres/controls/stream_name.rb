module Consumer
  module Postgres
    module Controls
      StreamName = ::Consumer::Controls::StreamName

      module StreamName
        module Position
          def self.example(id: nil, category: nil, randomize_category: nil, types: nil)
            category ||= Controls::Category.example(category: category)
            types ||= []

            types << 'position'

            StreamName.example(
              id: id,
              category: category,
              randomize_category: randomize_category,
              types: types
            )
          end

          module Category
            def self.example(category: nil)
              category ||= Controls::Category.example(category: category)

              position_type = 'position'

              MessageStore::StreamName.stream_name(category, type: position_type)
            end
          end
        end
      end
    end
  end
end

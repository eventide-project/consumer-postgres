module Consumer
  module Postgres
    module Controls
      StreamName = Messaging::Controls::StreamName

      module StreamName
        module Position
          def self.example(id: nil, category: nil, types: nil)
            category ||= Controls::Category.example(category: category)
            types ||= []

            types << 'position'

            Messaging::Controls::StreamName.example(
              id: id,
              category: category,
              types: types
            )
          end
        end
      end
    end
  end
end

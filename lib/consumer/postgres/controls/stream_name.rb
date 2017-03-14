module Consumer
  module Postgres
    module Controls
      StreamName = ::Consumer::Controls::StreamName

      module StreamName
        module Position
          def self.example(id: nil, randomize_category: nil, types: nil)
            types ||= []

            types << 'position'

            StreamName.example(
              id: id,
              randomize_category: randomize_category,
              types: types
            )
          end

          module Category
            def self.example(category: nil)
              category = Controls::Category.example category: category

              position_type = 'position'

              EventSource::Postgres::StreamName.stream_name category, type: position_type
            end
          end
        end
      end
    end
  end
end

module Consumer
  module Postgres
    module Controls
      module Condition
        module Correlation
          def self.example(category:)
            "metadata->>'correlationStreamName' like '#{category}-%'"
          end
        end

        module Ordinary
          def self.example
            'some condition'
          end
        end
      end
    end
  end
end

module Consumer
  module Postgres
    module Controls
      module Consumer
        def self.example
          Example.build
        end

        class Example
          include ::Consumer::Postgres

          stream Controls::StreamName.example
        end
      end
    end
  end
end

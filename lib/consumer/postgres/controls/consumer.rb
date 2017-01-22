module Consumer
  module Postgres
    module Controls
      module Consumer
        def self.example
          Example.build
        end

        class Example
          include ::Consumer::Postgres
        end
      end
    end
  end
end

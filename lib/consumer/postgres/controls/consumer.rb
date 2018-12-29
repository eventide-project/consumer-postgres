module Consumer
  module Postgres
    module Controls
      module Consumer
        class Example
          include ::Consumer::Postgres

          handler Handler
        end

        class Identifier
          include ::Consumer::Postgres

          identifier Controls::Identifier.example
        end
      end
    end
  end
end

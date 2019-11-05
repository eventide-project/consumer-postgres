module Consumer
  module Postgres
    module Controls
      module Condition
        module ConsumerGroup
          def self.example(group_size:, group_member:)
            "@hash_64(stream_name) % #{group_size} = #{group_member}"
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

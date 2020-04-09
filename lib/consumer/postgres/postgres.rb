module Consumer
  module Postgres
    def self.included(cls)
      cls.class_exec do
        include ::Consumer

        attr_accessor :batch_size
        attr_accessor :correlation
        attr_accessor :group_member
        attr_accessor :group_size
        attr_accessor :condition
      end
    end

    def print_startup_info
      STDOUT.puts "      Correlation: #{correlation || '(none)'}"

      unless group_member.nil? && group_size.nil?
        STDOUT.puts "      Group Member: #{group_member.inspect}"
        STDOUT.puts "      Group Size: #{group_size.inspect}"
      end

      unless condition.nil?
        STDOUT.puts "      Condition: #{condition.inspect || '(none)'}"
      end
    end

    def log_startup_info
      logger.info(tags: [:consumer, :start]) { "Correlation: #{correlation.inspect} (Consumer: #{self.class.name})" }
      logger.info(tags: [:consumer, :start]) { "Batch Size: #{get.batch_size.inspect} (Consumer: #{self.class.name})" }
      logger.info(tags: [:consumer, :start]) { "Group Member: #{group_member.inspect} (Consumer: #{self.class.name})" }
      logger.info(tags: [:consumer, :start]) { "Group Size: #{group_size.inspect} (Consumer: #{self.class.name})" }
      logger.info(tags: [:consumer, :start]) { "Condition: #{condition.inspect} (Consumer: #{self.class.name})" }
    end

    def starting
      if identifier.nil? && !group_member.nil? && !group_size.nil?
        raise Identifier::Error, 'Identifier must not be omitted when the consumer is a member of a group'
      end
    end

    def configure(batch_size: nil, settings: nil, correlation: nil, group_member: nil, group_size: nil, condition: nil)
      self.batch_size = batch_size
      self.correlation = correlation
      self.group_member = group_member
      self.group_size = group_size
      self.condition = condition

      MessageStore::Postgres::Session.configure(self, settings: settings)
      session = self.session

      get_session = MessageStore::Postgres::Session.build(settings: settings)

      MessageStore::Postgres::Get::Category.configure(
        self,
        category,
        batch_size: batch_size,
        correlation: correlation,
        consumer_group_member: group_member,
        consumer_group_size: group_size,
        condition: condition,
        session: get_session
      )

      PositionStore.configure(
        self,
        category,
        consumer_identifier: identifier,
        session: session
      )
    end
  end
end

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

    def starting
      unless batch_size.nil?
        logger.info(tag: :*) { "Batch Size: #{batch_size}" }
      end

      unless correlation.nil?
        logger.info(tag: :*) { "Correlation: #{correlation}" }
      end

      unless identifier.nil?
        logger.info(tag: :*) { "Identifier: #{identifier}" }
      end

      unless group_member.nil? && group_size.nil?
        logger.info(tag: :*) { "Group Member: #{group_member.inspect}, Group Size: #{group_size.inspect}" }
      end

      unless condition.nil?
        logger.info(tag: :*) { "Condition: #{condition}" }
      end

      unless poll_interval_milliseconds.nil?
        logger.info(tag: :*) { "Poll Interval Milliseconds: #{poll_interval_milliseconds}" }
      end

      unless position_update_interval.nil?
        logger.info(tag: :*) { "Position Update Interval: #{position_update_interval}" }
      end

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

module Consumer
  module Postgres
    Error = Class.new(RuntimeError)

    def self.included(cls)
      cls.class_exec do
        include ::Consumer

        attr_accessor :batch_size
        attr_accessor :condition
        attr_accessor :correlation
        attr_accessor :composed_condition
      end
    end

    def starting
      unless batch_size.nil?
        logger.info(tag: :*) { "Batch Size: #{batch_size}" }
      end

      unless correlation.nil?
        logger.info(tag: :*) { "Correlation: #{correlation}" }
      end

      unless condition.nil?
        ## TODO Was this supposed to be condition rather than composed_condition?
        logger.info(tag: :*) { "Condition: #{composed_condition}" }
      end

      unless composed_condition.nil?
        logger.debug(tag: :*) { "Composed Condition: #{composed_condition}" }
      end
    end

    def configure(batch_size: nil, settings: nil, correlation: nil, group_size: nil, group_member: nil, condition: nil)
      AssureGroup.(group_size, group_member)

      composed_condition = Condition.compose(correlation: correlation, condition: condition)

      self.batch_size = batch_size
      self.correlation = correlation
      self.condition = condition
      self.composed_condition = composed_condition

      MessageStore::Postgres::Session.configure(self, settings: settings)

      session = self.session

      PositionStore.configure(
        self,
        stream_name,
        consumer_identifier: identifier,
        session: session
      )

      get_session = MessageStore::Postgres::Session.build(settings: settings)
      MessageStore::Postgres::Get.configure(
        self,
        batch_size: batch_size,
        condition: composed_condition,
        session: get_session
      )
    end

    module AssureGroup
      def self.call(group_size, group_member)
        error_message = 'Consumer group definition is incorrect.'

        arguments_count = [group_size, group_member].compact.length

        if arguments_count == 1
          raise Error, "#{error_message} Group size and group member are both required. (Group Size: #{group_size.inspect}, Group Member: #{group_member.inspect})"
        end

        return if arguments_count == 0

        if group_size < 1
          raise Error, "#{error_message} Group size must not be less than 1. (Group Size: #{group_size.inspect}, Group Member: #{group_member.inspect})"
        end

        if group_member < 0
          raise Error, "#{error_message} Group member must not be less than 0. (Group Size: #{group_size.inspect}, Group Member: #{group_member.inspect})"
        end

        if group_member > group_size
          raise Error, "#{error_message} Group member must not be greater than group size. (Group Size: #{group_size.inspect}, Group Member: #{group_member.inspect})"
        end
      end
    end

    module Condition
      extend self

      def compose(condition: nil, correlation: nil)
        composed_condition = []

        unless condition.nil?
          composed_condition << condition
        end

        unless correlation.nil?
          Correlation.assure(correlation)

          composed_condition << "metadata->>'correlationStreamName' like '#{correlation}-%'"
        end

        return nil if composed_condition.empty?

        sql_condition = composed_condition.join(' AND ')

        sql_condition
      end
    end

    module Correlation
      Error = Class.new(RuntimeError)

      def self.assure(correlation)
        unless MessageStore::StreamName.category?(correlation)
          raise Correlation::Error, "Correlation must be a category (Correlation: #{correlation})"
        end
      end
    end
  end
end

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
##        attr_accessor :composed_condition
      end
    end

    def starting
      unless batch_size.nil?
        logger.info(tag: :*) { "Batch Size: #{batch_size}" }
      end

      unless correlation.nil?
        logger.info(tag: :*) { "Correlation: #{correlation}" }
      end

      unless group_member.nil? && group_size.nil?
        logger.info(tag: :*) { "Group Member: #{group_member.inspect}, Group Size: #{group_size.inspect}" }
      end

      unless condition.nil?
        logger.info(tag: :*) { "Condition: #{condition}" }
      end

##
      # unless composed_condition.nil?
      #   logger.debug(tag: :*) { "Composed Condition: #{composed_condition}" }
      # end
    end

    def configure(batch_size: nil, settings: nil, correlation: nil, group_member: nil, group_size: nil, condition: nil)
      ## composed_condition = Condition.compose(group_member: group_member, group_size: group_size, condition: condition)

      self.batch_size = batch_size
      self.correlation = correlation
      self.group_member = group_member
      self.group_size = group_size
      self.condition = condition
##      self.composed_condition = composed_condition

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
        stream_name,
        batch_size: batch_size,
        correlation: correlation,
        consumer_group_member: group_member,
        consumer_group_size: group_size,
##        condition: composed_condition,
        condition: condition,
        session: get_session
      )
    end

    module Condition
      extend self

      def ___compose(condition: nil, group_member: nil, group_size: nil)
        composed_condition = []

        unless condition.nil?
          composed_condition << condition
        end

        unless group_member.nil? && group_size.nil?
          Group.assure(group_member, group_size)
          composed_condition << "@hash_64(stream_name) % #{group_size} = #{group_member}"
        end

        return nil if composed_condition.empty?

        sql_condition = composed_condition.join(' AND ')

        sql_condition
      end
    end

    module Group
      Error = Class.new(RuntimeError)

      def self.assure(group_member, group_size)
        error_message = 'Consumer group definition is incorrect.'

        arguments_count = [group_size, group_member].compact.length

        if arguments_count == 1
          raise Error, "#{error_message} Group size and group member are both required. (Group Member: #{group_member.inspect}, Group Size: #{group_size.inspect})"
        end

        return if arguments_count == 0

        if group_size < 1
          raise Error, "#{error_message} Group size must not be less than 1. (Group Member: #{group_member.inspect}, Group Size: #{group_size.inspect})"
        end

        if group_member < 0
          raise Error, "#{error_message} Group member must not be less than 0. (Group Member: #{group_member.inspect}, Group Size: #{group_size.inspect})"
        end

        if group_member >= group_size
          raise Error, "#{error_message} Group member must be at least one less than group size. (Group Member: #{group_member.inspect}, Group Size: #{group_size.inspect})"
        end
      end
    end
  end
end

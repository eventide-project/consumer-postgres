require_relative '../interactive_init'

logger = Log.get "Consumer Group Test"

category = ENV['CATEGORY'] || 'testPostgresConsumerGroup'
logger.info "Category: #{category}"

group_size = Integer(ENV['GROUP_SIZE'] || 2)
logger.info "Group Size: #{group_size}"

group_member = Integer(ENV['GROUP_MEMBER'] || 1)
logger.info "Group Member: #{group_member}"

position_update_interval = (ENV['POSITION_UPDATE_INTERVAL'] || 10).to_i

if identifier = ENV['IDENTIFIER']
  Controls::Consumer::Example.class_exec do
    identifier(identifier)
  end
end

condition = ENV['CONDITION']

Actor::Supervisor.start do
  Controls::Consumer::Example.start(
    category,
    condition: condition,
    group_size: group_size,
    group_member: group_member,
    position_update_interval: position_update_interval
  )
end

require_relative './interactive_init'

category = ENV['CATEGORY'] || 'testPostgresConsumer'

position_update_interval = (ENV['POSITION_UPDATE_INTERVAL'] || 10).to_i

if identifier = ENV['IDENTIFIER']
  Controls::Consumer::Incrementing.class_exec do
    identifier(identifier)
  end
end

condition = ENV['CONDITION']

Actor::Supervisor.start do
  Controls::Consumer::Incrementing.start(
    category,
    condition: condition,
    position_update_interval: position_update_interval
  )
end

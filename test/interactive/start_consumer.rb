require_relative './interactive_init'

category = ENV['CATEGORY'] || 'testPostgresConsumer'

position_update_interval = (ENV['POSITION_UPDATE_INTERVAL'] || 10).to_i

Actor::Supervisor.start do
  Controls::Consumer::Incrementing.start(
    category,
    position_update_interval: position_update_interval
  )
end

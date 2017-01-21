require_relative './interactive_init'

Actor::Supervisor.start do
  PostgresInteractiveConsumer.start
end

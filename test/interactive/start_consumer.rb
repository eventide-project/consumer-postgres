require_relative './interactive_init'

Actor::Supervisor.start do
  stream = PostgresInteractiveConsumer.get_category

  PostgresInteractiveConsumer.start stream
end

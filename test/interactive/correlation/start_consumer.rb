require_relative '../interactive_init'

logger = Log.get "Correlation Test"

category = ENV['CATEGORY'] || 'testPostgresConsumerCorrelation'

logger.info "Category: #{category}"

correlation_cateogry = ENV['CORRELATION_CATEGORY'] || 'testCorrelation'

logger.info "Correlation Category: #{correlation_cateogry}"


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
    correlation: correlation_cateogry,
    position_update_interval: position_update_interval
  )
end

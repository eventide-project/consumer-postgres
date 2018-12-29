require_relative '../interactive_init'

logger = Log.get "Correlation Test"

write = Messaging::Postgres::Write.build

period = (ENV['PERIOD'] || 300).to_i


category = ENV['CATEGORY'] || 'testPostgresConsumerCorrelation'
stream_name = Controls::StreamName.example(category: category)

logger.info "Category: #{category}"
logger.info "Stream Name: #{stream_name}"

correlation_cateogry = ENV['CORRELATION_CATEGORY'] || 'testCorrelation'

logger.info "Correlation Category: #{correlation_cateogry}"


(1..2).to_a.cycle do |i|
  if i == 1
    correlation_stream_name = Controls::StreamName.example(category: correlation_cateogry)
  else
    correlation_stream_name = Controls::StreamName.example
  end

  message = Controls::Message.example(correlation: correlation_stream_name)

  position = write.(message, stream_name)

  logger.info "Wrote message (Correlation: #{message.metadata.correlation_stream_name}, Position: #{position})"

  sleep Rational(period, 1000)
end

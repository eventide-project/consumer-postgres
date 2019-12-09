require_relative './interactive_init'

category = ENV['CATEGORY'] || 'testPostgresConsumer'

write = Messaging::Postgres::Write.build

period = (ENV['PERIOD'] || 300).to_i

logger = Log.get "Consumer Test"

(1..4).to_a.cycle do |stream_id|
  stream_name = MessageStore::StreamName.stream_name(category, stream_id)

  message = Controls::Message.example

  position = write.(message, stream_name)

  logger.info "Wrote message (Stream Name: #{stream_name}, Position: #{position})"

  sleep Rational(period, 1000)
end

require_relative './interactive_init'

category = ENV['CATEGORY'] || 'testPostgresConsumer'

write = MessageStore::Postgres::Write.build

period = (ENV['PERIOD'] || 300).to_i

logger = Log.get "Consumer Test"

(1..4).to_a.cycle do |stream_id|
  stream_name = MessageStore::StreamName.stream_name(category, stream_id)

  message_data = Controls::MessageData::Write.example

  position = write.(message_data, stream_name)

  logger.info "Wrote message (Stream Name: #{stream_name}, Position: #{position})"

  sleep Rational(period, 1000)
end

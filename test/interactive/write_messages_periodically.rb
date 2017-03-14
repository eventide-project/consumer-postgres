require_relative './interactive_init'

category = ENV['CATEGORY'] || 'testPostgresConsumer'

write = EventSource::Postgres::Write.build

period = (ENV['PERIOD'] || 300).to_i

logger = Log.get __FILE__

(1..4).to_a.cycle do |stream_id|
  stream_name = EventSource::Postgres::StreamName.stream_name category, stream_id

  event = Controls::EventData.example

  position = write.(event, stream_name)

  logger.info "Wrote event (Stream Name: #{stream_name}, Position: #{position})"

  sleep Rational(period, 1000)
end

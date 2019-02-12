require_relative '../interactive_init'

logger = Log.get "Consumer Group Test"

write = Messaging::Postgres::Write.build

period = (ENV['PERIOD'] || 300).to_i


category = ENV['CATEGORY'] || 'testPostgresConsumerGroup'
logger.info "Category: #{category}"

group_size = ENV['GROUP_SIZE'] || '2'
logger.info "Group Size: #{group_size}"

stream_names = [
  Controls::StreamName.example(category: category),
  Controls::StreamName.example(category: SecureRandom.hex)
]

loop do
  stream_name = stream_names.sample

  message = Controls::Message.example

  position = write.(message, stream_name)

  logger.info "Wrote message (Position: #{position}, Stream Name: #{stream_name})"

  sleep Rational(period, 1000)
end

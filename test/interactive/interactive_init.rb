require_relative '../test_init'

class PostgresInteractiveConsumer
  include Consumer::Postgres

  position_store Controls::PositionStore::LocalFile
  cycle timeout_milliseconds: 1000

  def stream
    @stream ||= EventSource::Stream.new self.class.get_category
  end

  def self.get_category
    path = 'tmp/postgres-interactive-consumer'

    if File.exist? path
      File.read path
    else
      category = "someCategory#{SecureRandom.hex 7}"

      File.write path, category
    end
  end
end

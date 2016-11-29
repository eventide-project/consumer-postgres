ENV['LONG_POLL_DURATION'] ||= '1'

ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_COLOR'] ||= 'on'
ENV['LOG_LEVEL'] ||= 'trace'

puts RUBY_DESCRIPTION

require 'pp'
require_relative '../init.rb'

require 'test_bench/activate'

require 'consumer/postgres/controls'

Controls = Consumer::Postgres::Controls

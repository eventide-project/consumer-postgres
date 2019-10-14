ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= 'trace'

puts RUBY_DESCRIPTION

require 'pp'
require_relative '../init.rb'

require 'test_bench'; TestBench.activate

require 'consumer/postgres/controls'

Controls = Consumer::Postgres::Controls

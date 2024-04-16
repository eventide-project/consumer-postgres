# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-consumer-postgres'
  s.version = '2.4.0.0.dev.1'
  s.summary = 'Postgres implementation of continuous subscription to a category and message dispatching to handlers'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/consumer-postgres'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'evt-consumer', '>= 2.4.0.0.dev.1'
  s.add_runtime_dependency 'evt-messaging-postgres'

  s.add_development_dependency 'test_bench'
end

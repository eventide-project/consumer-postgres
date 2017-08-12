## Usage

### Defining a Postgres Consumer Class

```ruby
class SomeConsumer
  include Consumer::Postgres

  # Optional identifier that allows multiple consumers to maintain their
  # position offsets independently
  identifier 'someConsumerName'

  # Specifies a handler implementation for handling messages
  handler SomeHandler

  # Errors are handled by this method. If this method is omitted, the default
  # action when an error is raised during the handling of a message is to
  # re-raise the error.
  def error_raised(error, event_data)
    SomeErrorNotificationService.(error)

    WriteNotProcessable.(event_data)
  end
end
```

### Using a Consumer Class

The consumer can be started directly or through the use of [component-host](https://github.com/eventide-project/component-host). Use of ComponentHost is recommended for services deployed to a production environment.

#### Starting a Consumer Directly

```ruby
SomeConsumer.start("someCategory")
```

#### Starting via ComponentHost

See the [documentation](https://github.com/eventide-project/component-host) for information on how to use ComponentHost with consumers.

## License

The `consumer-postgres` library is released under the [MIT License](https://github.com/eventide-project/consumer/blob/master/MIT-License.txt).

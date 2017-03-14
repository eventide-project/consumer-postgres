## Usage

### Defining a Consumer Class

```ruby
class SomeConsumer
  include Consumer

  # Specifies handler implementations for handling messages
  handler SomeHandler
  handler OtherHandler

  # Errors are handled by this method. If omitted, the default action when an
  # error is raised during the dispatching of a message is to re-raise the error
  def error_raised(error, event_data)
    SomeErrorNotificationService.(error)

    WriteNotProcessable.(event_data)
  end
end
```

### Using a Consumer Class

The consumer can be started directly or through [process-host](https://github.com/eventide-project/process-host). Use of ProcessHost is recommended for services deployed to a production environment.

#### Starting a Consumer Directly

```ruby
SomeConsumer.start "someCategory"
```

#### Starting via ProcessHost

**TBD**

## License

The `consumer-postgres` library is released under the [MIT License](https://github.com/eventide-project/consumer-postgres/blob/master/MIT-License.txt).

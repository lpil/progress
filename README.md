# Progress

A service that is notified of progress updates and publishes updates
to subscribers.


```sh
# Run the application
mix phoenix.server

# Run the tests
mix test
mix test.watch --stale

# Build the docker image
mix docker.build && mix docker.release
```


## About

Progress is an umbrella application containing 3 OTP applications.

- Core: Where business logic lives.
- Memory: A Redis based ethereal data store.
- Web: A web interface with a JSON API and websocket based pubsub system.

### Request response cycle

1. Requests arrive through Web.
2. Web deserializes the request and calls Core.
3. Core utilises Memory for storage if needed and returns to Web.
4. Web responds to the request and broadcasts over pubsub if needed.

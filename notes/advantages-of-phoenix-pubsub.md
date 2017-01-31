```
chrismccord [8:27 PM]
@lpil plain cowboy ws is exactly what it is, a raw web socket handler

[8:27]
Phoenix channels (built on top of pubsub) gives you

[8:27]
multiplexed "channels" of communication on a single concrete connection. These
are isolated, concurrent processes

[8:28]
the server abstracts the transport layer, so you can use other transports,
such as long polling, or any custom wire protocol you can sent bits over

[8:29]
on the client, we handle connection recovery, message acknowledement for
req/respone style messaging

[8:29]
and lastly, we have a distributed pubsub layer that allows you to broadcast
messages across a cluster of nodes
```

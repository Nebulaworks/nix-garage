# Magic Wormhole Mailbox Server Docker Image
This defines a lightweight `docker image` that automatically starts a self-hosted rendezvous server for a [magic-womhole service](https://github.com/warner/magic-wormhole-mailbox-server). 

## Setup
The rendezvous server can be accessed locally at `localhost:4000`:
```
$ docker container run --name mailbox -d -p 4000:4000 nebulaworks/magic-wormhole-mailbox-server:latest
...
$ magic-wormhole --relay-url=ws://localhost:4000/v1 ...
```
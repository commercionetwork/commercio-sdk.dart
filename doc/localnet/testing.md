# Tests using a local network

SDK' tests can be executed by running a localnet full stack, follow [this guide](https://github.com/commercionetwork/commercionetwork/tree/master/contrib/localnet) to find how to start this net.

:::tip
The process of starting the local network using the command `make build-docker-cndode localnet-start` can take a long time because the `swagger` is generated; to avoid creating it, use the command `make GENERATE=0 build-docker-cndode localnet-start`.
:::

## Accounts

There are 4 nodes located in the folders `build/node<N>/cncli`.

## Endpoints

LCD, RPC and Websocket are activated on ports 7123 and 7124.

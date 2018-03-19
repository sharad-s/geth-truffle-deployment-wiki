
**_Terminal 1: Geth Node_**

##   1.1 Download Geth and add to PATH

Download the [latest Geth binary](https://geth.ethereum.org/downloads/) from their main website.

Geth is a reference _Ethereum Client_ which allows you to interact with the Ethereum network.



Place the geth binary in a folder of your choice, then add it to your path.

 - To add files/folders to path: https://youtu.be/5G2oGadQN0w

##   1.2 Run a light geth client on Ropsten testnet

Now that geth is installed, you can start your node and begin syncing.

`geth --testnet --rpc —-light --ipcpath "~/Library/Ethereum/geth.ipc”`

 - `—testnet` connects geth to the Ropsten testnet. Without it, your node would download and connect to the main Ethereum blockchain. We want to use the Ropsten testnet for all development purposes. There are different testnet flags available for testnets Kovan and Rinkeby.

 - `—light` allows your node to sync with the blockchain without having to download all the chain data. With `—light` you only have to download the block headers.

 - `—rpc` enables the HTTP-RPC server. This allows you to deploy contracts and send transactions through your running node.

 - `—ipcpath` sets the destination directory of your IPC endpoint. This IPC endpoint allows you to connect a different shell instance to the running geth node. This IPC path is important since geth can only have one running instance at a time. When we need to access the geth console, we will need to run `geth attach <ipc path>` in a separate shell window.

*Keep your geth instance running while you are planning to deploy contracts and send transactions!*

### _NOTE:_ Disk Space
Even though you are performing a light sync, be warned that this _can eat up your hard drive space quickly._

If geth does eat up your hard disk space, use `geth removedb` and `geth removedb --testnet` to delete all local chain data.

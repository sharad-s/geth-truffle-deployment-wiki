- _Terminal 1: Geth Node_
- **_Terminal 2: Geth Console_**

## 2.0.) Attach a new shell to a geth console session.

### Command
***


_In a new terminal window:_

`geth attach ~/Library/Ethereum/testnet/geth.ipc`

### Explanation

This uses the ipcpath you set with `--ipcpath` when starting your geth node.

This command uses the specified IPC endpoint to open a geth console session in a separate terminal window.

`geth attach ~/Library/Ethereum/testnet/geth.ipc`


## 2.1.) Check node sync status

### Command

_In geth console:_

`web3.eth.syncing`

### Explanation

Before we can use our node for anything, we have to make sure it is fully synced.

Check the sync status with:

`web3.eth.syncing`

If your node is finished syncing, `eth.syncing` will return `false`.

If your node is not finished syncing, you will see a JSON output with the parameters of the sync status:

```
//Fully synced
> eth.syncing
false

//Not fully synced
> eth.syncing
{
 currentBlock: 2847905,
 highestBlock: 2848197,
 knownStates: 35829,
 pulledStates: 25807,
 startingBlock: 2847842
}
```
**_Wait for a full sync before you continue._**

## 2.3) Check network ID

### Command

_In geth console:_

**Get NetworkID**

`web3.version.network`

### Explanation

This will return the networkID of the network your node is connected to.

We are connected to the Ropsten testnet so we are expecting a networkId of `3`

```
> web3.version.network
"3"
```

For a list of all available networkIDs on Ethereum [click here](https://ethereum.stackexchange.com/questions/17051/how-to-select-a-network-id-or-is-there-a-list-of-network-ids)

## 2.4) Accounts

### Commands

_In geth console:_

**Create New Account**

`personal.newAccount()` -> Enter password at prompt.

**Query Accounts**
- `web3.eth.accounts` : returns all accounts as list
- `web3.eth.coinbase` : returns `eth.accounts[0]`
- `web3.eth.accounts[i]` : returns `eth.accounts[i]`

### Explanation

When you first start your node you will always be given one account to start with. This is also known as your _coinbase_ account. It is responsible for deploying contracts by default.

Your coinbase account can addressed in the console as:

`web3.eth.accounts[0]` or `web3.eth.coinbase`

Subsequent accounts you create can be addressed by their index using `eth.accounts[i]`

You can check all your accounts with the command:

`web3.eth.accounts`

You can create new accounts to send/recieve transactions with, call contracts from different addresses, test security, and for a variety of other use-cases. Create a new account with the command:

`personal.newAccount()`

## 2.5) Getting some Test Ether for your new account

### Commands

**Check Account Balance**

- `web3.eth.getBalance(web3.eth.accounts[0])` - returns balance in wei

- `web3.fromWei(eth.getBalance(eth.accounts[0]))` - returns balance in ETH

### Explanation

We are using our accounts on the _Ropsten_ testnet, so we will have to go fund our accounts with Ropsten Ether.

Use a [Ropsten Faucet](http://faucet.ropsten.be:3001/) to fund your accounts. Be sure to fund your _coinbase_ account as it will need Ether to deploy contracts.

Wait for geth node full sync (Check with `eth.syncing`) then after the transaction confirms, check your account balances.

You can check the balance of any account with:

`web3.eth.getBalance(web3.eth.accounts[0])`


**_NOTE: Your coinbase account should have at least 1 ETH in it before you continue_**

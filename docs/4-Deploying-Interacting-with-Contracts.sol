# 4.) Deploying/Interacting With Contracts
- _Terminal 1: Geth Node_
- **_Terminal 2: Geth Console_**
- **_Terminal 3: Truffle Project Directory_**

## 4.0) Unlocking your coinbase address

You’ll need an unlocked account at your coinbase address to be able to deploy contracts or send transactions.

In geth console, type:

```personal.unlockAccount(eth.accounts[0])```.

Type in your password at the prompt to unlock your account.

Your unlocked account only lasts for a few minutes, so you will have to continually unlock your account as you develop. Just unlock your account before every deployment and transaction.

## 4.1) Compiling Contracts
_Window 3: truffle project dir_

Let’s compile our contracts to make sure there are no syntax errors.
You could throw your contract code into remix.ethereum.org to quickly check for compiler errors, but this works too.

`truffle compile`

If successful, the compiled JSON files will be output in `/build`

## 4.2) Deploying Contracts
Window 3: truffle project dir

`truffle migrate` = `truffle deploy` - no real difference in what they do. Up to you which command you prefer to use. In our case, we’ll use `truffle migrate`

`truffle migrate` compiles contracts if they haven’t been already.
By my preference we’ll delete the /build folder, then recompile and deploy our contracts in one step by using `truffle migrate`

Remember our network config file?
 We also want to deploy on the ropsten test network, so we’ll specify our config for ropsten by using the flag

 `—network ropsten`

Our final deployment command will look like this:

`rm -rf build ; truffle migrate --network ropsten`

If successful, our output will look like this:



Go ahead and copy/save the contract address of your newly deployed contract.
In my case it is this:
`	KyberETHConverter: 0xbab9fdbee2e23b4f04d19c93fb3a18cc6ea0b560`

## 4.3) Loading/Instantiating Deployed Contracts
_Window 2: geth console_

Now that your contract is deployed, let’s interact with it.
There are many methods to doing this - through our geth console or through services like [MyEtherWallet](https://www.myetherwallet.com/#contracts). Here we’ll cover geth console.

Regardless of which way you choose to interact with the contract, you will need two things:
 - The deployed contract address
 - The contract ABI

You can get the contract address from the output of step *4.2)*.
You can get the contract ABI from build/<deployed_contract>.json
The ABI in you want from the JSON file looks exactly like this:
```
 [
	{
		"constant": true,
     		 "inputs": [],
		"name": "MAX_UINT”,
		"outputs": [ { "name": "", "type": "uint256" } ],
		…
		…
   	 }
 ]
```
If this is confusing, just throw your contract into solidity remix, in the compile tab select your contract, click Details , then copy your ABI from there. To paste it in terminal, you may have to flatten the ABI and remove whitespace. Google “JSON remove whitespace” for this.
Your ABI should always begin with `[{` and end with `}]`.

Now you know you have found your contract address and ABI.
In geth console, let’s create variables for each.

```
Var abi = <paste ABI> 	// no quotes needed
Var contractAddress = “<contract address>” // address must be wrapped in double-quotes
```

Finally, let’s instantiate/load our deployed contract with the following command:
`var deployedContract = eth.contract(abi).at(contractAddress)`

You can confirm this succeeded by simply reading the variable you just created:
`> deployedContract`


## 4.4) Calling functions on deployed Contracts
_Window 2: geth console_

Now that we have our deployed contract instance stored in `deployedContract`, we can call functions on it via geth console.

_For a more visual interface, try out [MyEtherWallet](https://www.myetherwallet.com/#contracts) to interact with functions on deployed smart contracts. Again you will still need the contract ABI and Address._

### Public Variables, View-Only Functions
_Public variables_ on your contract are easy enough to call - each has it's own _getter_ function which can be called for free.

_Getters_ are a type of _view-only_ functions which are free to run since they only read data, not write data.

_Public, view-only functions_ can also be called for free in the same way.

Simply call `deployedContract.publicVariable()` or `deployedContract.publicFunction(<parameters>)` to call the public variable's getter function.


```
//Getting the address for Kyber Network on Ropsten stored publicly on our deployed contract.
> kyberETHConverter.kyberRopsten()
"0x0a56d8a49e71da8d7f9c65f95063db48a3c9560b"

//Calling function getConversionRate(address _destToken) to get the ETH/KNC rate
//KNC = "0xE5585362D0940519d87d29362115D4cc060C56B3"
> kyberETHConverter.getConversionRates(KNC)
[537134790187424429506, 521020746481801696620]
```

### Payable Functions, Transactions

```
//call convertFromETH using account[0], sending value of 1 ETH, and with gas limit at 200,000 gas:
//returns tx hash which can be looked up on ropsten.etherscan.io/tx/<hash>
> KyberETHConverter.convertFromETH(KNC, {"from": eth.accounts[0], "value": web3.toWei(1, "ether"), "gas": "200000"})
"0x8a2806d54dc70797fcd21d920b101d018669c1992bd0c318d397d3b393ab375e"

```

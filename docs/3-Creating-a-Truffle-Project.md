- _Terminal 1: Geth Node_
- _Terminal 2: Geth Console_
- **_Terminal 3: Truffle Project Directory_**

For greater reference, read the [truffle docs](http://truffleframework.com/docs/getting_started/installation)

## 3.0.) Install Truffle

### Command

_In a new terminal window_

**Install truffle**

`npm install -g truffle`


## 3.1) Create a Project skeleton

### Commands

_In your project directory:_

**Create Project Directory and Unbox Truffle MetaCoin**
```
mkdir <project name>
cd <project name>
truffle unbox metacoin
```

**Remove unnecessary files from MetaCoin**
```
rm contracts/ConvertLib.sol;
rm contracts/MetaCoin.sol;
rm test/metacoin.js;
rm test/testmetacoin.sol;
```
**ALT. Setup a barebones truffle project**

```
mkdir <project name>
cd <project name>
truffle init
```

### Explanation

We can finally setup our project in truffle.
Truffle has many boilerplates  available through _truffle boxes_. We will use the _MetaCoin_ box to initialize our project.

Let's **Create Project Directory and Unbox Truffle MetaCoin** .

```
mkdir <project name>
cd <project name>
truffle unbox metacoin
```

The MetaCoin boilerplate sets a few files up which will ease explanation for the sake of this tutorial (such as deployment scripts and truffle.js), but we don't actually care about the MetaCoin-related code. We can delete all contract and tests associated with MetaCoin.

Go ahead and **Remove unnecessary files from MetaCoin**.

```
rm contracts/ConvertLib.sol;
rm contracts/MetaCoin.sol;
rm test/metacoin.js;
rm test/testmetacoin.sol;
```

Now we’re good to go.


## 3.2) Set up truffle.js

### Code

_In project directory:_

**Install NPM package Web3**

- `npm init` -> follow prompt
- `npm install --save web3`

_In text editor:_

**truffle.js**

```
//truffle.js
const Web3 = require("web3");
const web3 = new Web3();

module.exports = {
 networks: {
   development: {
     host: "localhost",
     port: 8545,
     network_id: "*" // Match any network id
   },
   ropsten: {
     host: "localhost",
     port: 8545,
     network_id: 3,
     gas: 4600000,
     gasPrice: web3.toWei("21", "gwei")
   },
 }
};

```

### Explanation

We will set up truffle config to connect to our running geth client.
We need to connect to our personal geth client to be able to deploy contracts.

There is a method to set this up using Infura but we can [talk about that later.](http://truffleframework.com/tutorials/using-infura-custom-provider)

## 3.3) Write Your Contracts

### Commands

_In text editor:_

**Contract Code**

```
//contracts/Contract.sol
<contract code>
```
** Write Contract Code! **

### Explanation

Write your contracts. Put them in `contracts/`
<simple_contract.sol> or <contract_with_imports.sol>

_Aside: Why use migrations.sol?  What are migrations?_
Talk about Migrations, relation to DB migrations, how the contract helps, Segway into truffle deployment with `1_initial_migration.js`



## 3.4) Modify Your Deploy Script.

### Code

**Deployment Script**

```
//migrations/2_deploy_contract.js
var ShitCoin = artifacts.require("./ShitCoin.sol");

module.exports = function(deployer) {
 deployer.deploy(ShitCoin);
};
```

### Explanation

Modify/create file `migrations/2_deploy_contracts.js`

You need to name your deployment file as `2_<name>.js`. Truffle looks for a file starting with “2_” when running `truffle migrate` or `truffle deploy` to know that this is the second file to run in the deployment process (the first being `1_initial_migration.js`).

Create contract var as a require() statement. Use the contract name, not filename (since it is creating the artifact from the ABI.)

## 3.5) Compile Your Contracts

### Commands
_In truffle project directory_

**Compile Contracts**

`truffle compile`

## Explanation

Let’s compile our contracts to make sure there are no syntax errors.

`truffle compile`

If successful, the compiled JSON files will be output in `/build`
This JSON output will contain our compiled contract ABI, which we will need to interact with the deployed contract.

Another way to compile could throw your contract code into [solidity remix](remix.ethereum.org) to quickly check for compiler errors. You can grab the ABI from there as well.

## 3.6) Get Ready to Deploy Your Contracts

Before you can go ahead and deploy you should have these things:

- A running/fully synced Geth Node (connected to Testnet).  _Window 1_

- A geth console session (`geth attach <ipc path>`) _Window 2_

- A network config in `truffle.js` and a deployment script in `migrations/2_deploy_contracts.js` _Window 3_

<show what your project should look like at this point>

_**If all these items are in check, then we can succesfully deploy our contract.**_

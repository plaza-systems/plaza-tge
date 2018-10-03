let secrets = require('./secrets');

const WalletProvider = require("truffle-wallet-provider");
const Wallet = require('ethereumjs-wallet');

let mainNetPrivateKey = new Buffer(secrets.mainnetPK, "hex");
let mainNetWallet = Wallet.fromPrivateKey(mainNetPrivateKey);
let mainNetProvider = new WalletProvider(mainNetWallet, "https://mainnet.infura.io/");

let ropstenPrivateKey = new Buffer(secrets.ropstenPK, "hex");
let ropstenWallet = Wallet.fromPrivateKey(ropstenPrivateKey);
let ropstenProvider = new WalletProvider(ropstenWallet,  "https://ropsten.infura.io/");

let kovanPrivateKey = new Buffer(secrets.kovanPK, "hex");
let kovanWallet = Wallet.fromPrivateKey(kovanPrivateKey);
let kovanProvider = new WalletProvider(kovanWallet,  "https://kovan.infura.io/");

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    ropsten: { 
      provider: ropstenProvider, 
      network_id: "3", 
      gasPrice: 10e9, // 10 gwei
      gas: 4465030 
    },
    kovan: { 
      provider: kovanProvider, 
      network_id: "42", 
      gasPrice: 10e9, // 10 gwei
      gas: 4465030 
    },
    live: { 
      provider: mainNetProvider, 
      network_id: "1", 
      gasPrice: 8e9, // 8 gwei
      gas: 7500000 
    }
  }
};

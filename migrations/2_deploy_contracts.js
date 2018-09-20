var PlazaToken = artifacts.require("./PlazaToken.sol");

module.exports = function(deployer) {
  const utils = require("../test/utils");
  const tokenDecimals = 18;
  
  const token = {
    "name": "Plaza Token",
    "ticker": "PLAZA",
    "decimals": tokenDecimals,
    "cap": utils.toFixed(960000000 * 10**tokenDecimals)
  };

  const tokenParams = [
    token.name,
    token.ticker,
    parseInt(token.decimals, 10),
    parseInt(token.cap, 10)
  ];
 
  deployer.deploy(PlazaToken, ...tokenParams);
};

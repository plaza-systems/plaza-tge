//var PlazaToken = artifacts.require("./PlazaToken.sol");
var PlazaCrowdsale = artifacts.require("./PlazaCrowdsale.sol");

module.exports = function(deployer) {
  const utils = require("../test/utils");
  const tokenDecimals = 18;
  
/*   const token = {
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
 */
  const startTime = 1538643600;
  const oneDay = 86400;
  // const oneHour = 3600;
 
  const crowdsale = {
    "openingTime": startTime,
    "closingTime": utils.toFixed(startTime + (oneDay * 42)),
    "rate": 5000,
    "wallet": "0xdadec2326bd7820de2d3b505b373d0ad0a1206ad",
    "cap": utils.toFixed(500000000 * 10**tokenDecimals),
    "token": "0x51AA10BdC19780d440261f67158016188a7207e2",
    "openingTimeTier4": utils.toFixed(startTime + (oneDay * 14)),
    "openingTimeTier3": utils.toFixed(startTime + (oneDay * 7)),
    "openingTimeTier2": utils.toFixed(startTime + oneDay),
    "invCap": utils.toFixed(10000 * 10**tokenDecimals)
  };

  const crowdsaleParams = [
    parseInt(crowdsale.openingTime, 10), 
    parseInt(crowdsale.closingTime, 10), 
    parseInt(crowdsale.rate, 10), 
    crowdsale.wallet, 
    parseInt(crowdsale.cap, 10),
    crowdsale.token,
    parseInt(crowdsale.openingTimeTier4, 10),
    parseInt(crowdsale.openingTimeTier3, 10),
    parseInt(crowdsale.openingTimeTier2, 10),
    parseInt(crowdsale.invCap, 10)
  ];

  deployer.deploy(PlazaCrowdsale, ...crowdsaleParams);
};

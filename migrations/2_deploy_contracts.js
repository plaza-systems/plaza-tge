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
  const startTime = 1538384400;
  const oneDay = 86400;
  // const oneHour = 3600;
 
  const crowdsale = {
    "openingTime": startTime,
    "closingTime": 1542013200,
    "rate": 5000,
    "wallet": "0x27988b01f416069bf09c789333f3143e66756e3a",
    "cap": utils.toFixed(500000000 * 10**tokenDecimals),
    "token": "0xd2525b37b4c1f07bb540c44dd09c96d8587fe891",
    "openingTimeTier4": utils.toFixed(startTime + (oneDay * 14)),
    "openingTimeTier3": utils.toFixed(startTime + (oneDay * 7)),
    "openingTimeTier2": utils.toFixed(startTime + oneDay),
    "invCap": utils.toFixed(2500 * 10**tokenDecimals)
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

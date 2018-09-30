var PlazaToken = artifacts.require("./PlazaToken.sol");
var PlazaCrowdsale = artifacts.require("./PlazaCrowdsale.sol");

/* module.exports = function(deployer) {
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
 */

module.exports = (deployer) => {
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

  const startTime = 1538314200;
  const oneDay = 86400;
  const oneHour = 3600;
 
  const crowdsale = {
    "openingTime": startTime,
    "closingTime": utils.toFixed(startTime + (oneHour * 2)),
    "rate": 5000,
    "wallet": "0x27988b01f416069bf09c789333f3143e66756e3a",
    "cap": utils.toFixed(500000000 * 10**tokenDecimals),
    "openingTimeTier4": utils.toFixed(startTime + (oneHour * 1.5)),
    "openingTimeTier3": utils.toFixed(startTime + oneHour),
    "openingTimeTier2": utils.toFixed(startTime + (oneHour * 0.5))
  };

  return deployer
    .then(() => deployer.deploy(PlazaToken, ...tokenParams))
    .then(() => deployer.deploy(
      PlazaCrowdsale, 
      crowdsale.openingTime, 
      crowdsale.closingTimetruffle, 
      crowdsale.rate, 
      crowdsale.wallet, 
      crowdsale.cap, 
      PlazaToken.address,
      crowdsale.openingTimeTier4,
      crowdsale.openingTimeTier3,
      crowdsale.openingTimeTier2
    ));
    //.then(() => PlazaCrowdsale.deployed())
    //.then(token => token.increaseApproval(PresaleCrowdsale.address, 1000000 * (10 ** 18)));
};

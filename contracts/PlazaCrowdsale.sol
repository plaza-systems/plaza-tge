pragma solidity ^0.4.24;

import "./CappedWhitelistedCrowdsale.sol";
import "./TieredPriceCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract PlazaCrowdsale is CappedWhitelistedCrowdsale, FinalizableCrowdsale, MintedCrowdsale, TieredPriceCrowdsale {

    constructor(
        uint256 openingTime,
        uint256 closingTime,
        uint256 rate,
        address wallet,
        uint256 cap,
        ERC20Mintable token,
        uint256 openingTimeTier4,
        uint256 rateTier3, 
        uint256 openingTimeTier3, 
        uint256 rateTier2, 
        uint256 openingTimeTier2, 
        uint256 rateTier1
    )
    public
    Crowdsale(rate, wallet, token)
    CappedWhitelistedCrowdsale(cap)
    TimedCrowdsale(openingTime, closingTime)
    TieredPriceCrowdsale(rate, openingTimeTier4, rateTier3, openingTimeTier3, rateTier2, openingTimeTier2, rateTier1)
    {}
}
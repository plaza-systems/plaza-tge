pragma solidity ^0.4.24;

import "./TieredPriceCrowdsale.sol";
import "./WhitelistedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract PlazaCrowdsale is CappedCrowdsale, FinalizableCrowdsale, MintedCrowdsale, WhitelistedCrowdsale, TieredPriceCrowdsale {
    constructor(
        uint256 openingTime,
        uint256 closingTime,
        uint256 rate,
        address wallet,
        uint256 cap,
        ERC20Mintable token,
        uint256 openingTimeTier4, 
        uint256 openingTimeTier3, 
        uint256 openingTimeTier2,
        uint256 invCap
    )
    public
    Crowdsale(rate, wallet, token)
    CappedCrowdsale(cap)
    WhitelistedCrowdsale(invCap)
    TimedCrowdsale(openingTime, closingTime)
    TieredPriceCrowdsale(rate, openingTimeTier2, openingTimeTier3, openingTimeTier4)
    {}

}
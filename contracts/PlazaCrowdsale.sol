pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract PlazaCrowdsale is CappedCrowdsale, FinalizableCrowdsale, MintedCrowdsale {

    constructor(
        uint256 openingTime,
        uint256 closingTime,
        uint256 rate,
        address wallet,
        uint256 cap,
        ERC20Mintable token
    )
    public
    Crowdsale(rate, wallet, token)
    CappedCrowdsale(cap)
    TimedCrowdsale(openingTime, closingTime)
    {}
}
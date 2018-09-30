pragma solidity ^0.4.24;

import "./TieredPriceCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/IndividuallyCappedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";

contract PlazaCrowdsale is CappedCrowdsale, IndividuallyCappedCrowdsale, FinalizableCrowdsale, MintedCrowdsale, TieredPriceCrowdsale {
    constructor(
        uint256 openingTime,
        uint256 closingTime,
        uint256 rate,
        address wallet,
        uint256 cap,
        ERC20Mintable token,
        uint256 openingTimeTier4, 
        uint256 openingTimeTier3, 
        uint256 openingTimeTier2
    )
    public
    Crowdsale(rate, wallet, token)
    CappedCrowdsale(cap)
    IndividuallyCappedCrowdsale()
    TimedCrowdsale(openingTime, closingTime)
    TieredPriceCrowdsale(rate, openingTimeTier2, openingTimeTier3, openingTimeTier4)
    {}

    /**
    * @dev Checks whether the beneficiary is in the whitelist.
    * @param beneficiary Address to be checked
    * @return Whether the beneficiary is whitelisted
    */

    function isWhitelisted(address beneficiary) public view returns (bool) {
        return getCap(beneficiary) != 0;
    }
}
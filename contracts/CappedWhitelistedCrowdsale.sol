pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "openzeppelin-solidity/contracts/crowdsale/validation/IndividuallyCappedCrowdsale.sol";

/**
 * @title CappedWhitelistedCrowdsale
 * @dev Crowdsale with a limit for total contributions and per-beneficiary caps. 
 * Combination of CappedCrowdsale and IndividuallyCappedCrowdsale
 */
contract CappedWhitelistedCrowdsale is CappedCrowdsale, IndividuallyCappedCrowdsale {
  mapping(address => uint256) private _contributions;
  mapping(address => uint256) private _caps;

  uint256 private _cap;

  /**
   * @dev Constructor, takes maximum amount of wei accepted in the crowdsale.
   * @param cap Max amount of wei to be contributed
   */
  constructor(uint256 cap) public {
    require(cap > 0);
    _cap = cap;
  }

  /**
   * @dev Checks whether the beneficiary is in the whitelist.
   * @param beneficiary Address to be checked
   * @return Whether the beneficiary is whitelisted
   */
  function isWhitelisted(address beneficiary) public view returns (bool) {
    return _caps[beneficiary] != 0;
  }

  /**
   * @dev Extend parent behavior requiring purchase to respect the funding cap.
   * @param beneficiary Token purchaser
   * @param weiAmount Amount of wei contributed
   */
  function _preValidatePurchase(
    address beneficiary,
    uint256 weiAmount
  )
    internal
  {
    super._preValidatePurchase(beneficiary, weiAmount);
    require(weiRaised().add(weiAmount) <= _cap);
    require(_contributions[beneficiary].add(weiAmount) <= _caps[beneficiary]);    
  }

}

pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";


/**
 * @title CappedWhitelistedCrowdsale
 * @dev Crowdsale with a limit for total contributions and per-beneficiary caps. 
 * Combination of CappedCrowdsale and IndividuallyCappedCrowdsale
 */
contract TieredPriceCrowdsale is Crowdsale {
  using SafeMath for uint256;

  uint256 private _rate1;
  uint256 private _rate2;
  uint256 private _rate3;
  uint256 private _rate4;
  uint256 private _bonusRate;

  uint256 private _tier2Start;
  uint256 private _tier3Start;
  uint256 private _tier4Start;

  constructor( 
    uint256 rateTier4, 
    uint256 openingTimeTier4,
    uint256 rateTier3, 
    uint256 openingTimeTier3, 
    uint256 rateTier2, 
    uint256 openingTimeTier2, 
    uint256 rateTier1
  ) 
  public 
  {
    require(rateTier1 > 0);
    require(rateTier2 > 0);
    require(rateTier3 > 0);
    require(rateTier4 > 0);

    _rate1 = rateTier1;
    _rate2 = rateTier2;
    _rate3 = rateTier3;
    _rate4 = rateTier4;

    _tier2Start = openingTimeTier2;
    _tier3Start = openingTimeTier3;
    _tier4Start = openingTimeTier4;
  }

  /**
   * @return the current bonus level.
   */
  function bonusRate() public view returns(uint256) {
    return _getbonusRate();
  }

 /**
   * @dev Override to extend the way in which ether is converted to tokens.
   * @param weiAmount Value in wei to be converted into tokens
   * @return Number of tokens that can be purchased with the specified _weiAmount
   */
  function _getTokenAmount(
    uint256 weiAmount
  )
    internal view returns (uint256)
  {
    super._getTokenAmount(weiAmount);

    _bonusRate = _getbonusRate();

    return weiAmount.mul(_bonusRate);
  }

  function _getbonusRate()
    internal view returns (uint256)
  {
    // Add current bonus to rate
    if(_tier2Start > block.timestamp){
      _bonusRate = _rate1;
    }
    else if(_tier3Start > block.timestamp){
      _bonusRate = _rate2;
    }
    else if(_tier4Start > block.timestamp){
      _bonusRate = _rate3;
    }
    else {
      _bonusRate = _rate4;
    }
    return _bonusRate;
  }
  
}
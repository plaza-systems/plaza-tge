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

    uint256 private _baseRate;
    uint256 private _tier2Start;
    uint256 private _tier3Start;
    uint256 private _tier4Start;

    constructor( 
      uint256 baseRate,
      uint256 openingTimeTier2,
      uint256 openingTimeTier3, 
      uint256 openingTimeTier4
    ) 
    public 
    {
        require(baseRate > 0);
        require(openingTimeTier2 > block.timestamp);
        require(openingTimeTier3 >= openingTimeTier2);
        require(openingTimeTier4 >= openingTimeTier3);

        _baseRate = baseRate;
        _tier4Start = openingTimeTier4;
        _tier3Start = openingTimeTier3;
        _tier2Start = openingTimeTier2;
    }

    function _getbonusRate()
      internal view returns (uint256)
    {
        // Calculate current rate with bonus
        if(_tier2Start > block.timestamp){
            return(_baseRate * 6 / 5);
        }
        else if(_tier3Start > block.timestamp){
            return(_baseRate * 11 / 10);
        }
        else if(_tier4Start > block.timestamp){
            return(_baseRate * 21 / 20);
        }
        else {
            return(_baseRate);
        }
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
        return weiAmount.mul(_getbonusRate());
    }
}
pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol";
import "openzeppelin-solidity/contracts/access/roles/CapperRole.sol";


/**
 * @title WhitelistedCrowdsale
 * @dev Crowdsale with whitelist required for purchases, based on IndividuallyCappedCrowdsale.
 */
contract WhitelistedCrowdsale is Crowdsale, CapperRole {
    using SafeMath for uint256;

    uint256 private _invCap;   

    mapping(address => uint256) private _contributions;
    mapping(address => uint256) private _caps;

    constructor(uint256 invCap) public
    {
        require(invCap > 0);
        _invCap = invCap;
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
    * @dev add an address to the whitelist
    * @param beneficiary address
    * @return true if the address was added to the whitelist, false if the address was already in the whitelist
    */
    function addAddressToWhitelist(address beneficiary) public onlyCapper returns (bool) {
        require(beneficiary != address(0));
        _caps[beneficiary] = _invCap;
        return isWhitelisted(beneficiary);
    }

    /**
    * @dev add addresses to the whitelist
    * @param _beneficiaries addresses
    * @return true if at least one address was added to the whitelist,
    * false if all addresses were already in the whitelist
    */
    function addAddressesToWhitelist(address[] _beneficiaries) external onlyCapper {
        for (uint256 i = 0; i < _beneficiaries.length; i++) {
            addAddressToWhitelist(_beneficiaries[i]);
        }
    }

    /**
    * @dev remove an address from the whitelist
    * @param beneficiary address
    * @return true if the address was removed from the whitelist, false if the address wasn't already in the whitelist
    */
    function removeAddressFromWhitelist(address beneficiary) public onlyCapper returns (bool) {
        require(beneficiary != address(0));
        _caps[beneficiary] = 0;
        return isWhitelisted(beneficiary);
    }

    /**
    * @dev remove addresses from the whitelist
    * @param _beneficiaries addresses
    * @return true if at least one address was removed from the whitelist,
    * false if all addresses weren't already in the whitelist
    */
    function removeAddressesFromWhitelist(address[] _beneficiaries) external onlyCapper {
        for (uint256 i = 0; i < _beneficiaries.length; i++) {
            removeAddressFromWhitelist(_beneficiaries[i]);
        }
    }

    /**
    * @dev Returns the amount contributed so far by a specific beneficiary.
    * @param beneficiary Address of contributor
    * @return Beneficiary contribution so far
    */
    function getContribution(address beneficiary)
    public view returns (uint256)
    {
        return _contributions[beneficiary];
    }

    /**
    * @dev Extend parent behavior requiring purchase to respect the beneficiary's funding cap.
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
        require(
            _contributions[beneficiary].add(weiAmount) <= _caps[beneficiary]);
    }

    /**
    * @dev Extend parent behavior to update beneficiary contributions
    * @param beneficiary Token purchaser
    * @param weiAmount Amount of wei contributed
    */
    function _updatePurchasingState(
        address beneficiary,
        uint256 weiAmount
    )
    internal
    {
        super._updatePurchasingState(beneficiary, weiAmount);
        _contributions[beneficiary] = _contributions[beneficiary].add(weiAmount);
    }

}
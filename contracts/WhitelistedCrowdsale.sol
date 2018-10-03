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
    mapping(address => uint256) private _whitelist;

    /**
    * Event for when _account is added or removed from whitelist
    * @param _account address added or removed
    * @param _phase represents the whitelist status (0:unwhitelisted, 1:whitelisted)​
    */
    event WhitelistUpdated(
        address indexed _account,
        uint8 _phase
    );

    constructor(uint256 invCap) public
    {
        require(invCap > 0);
        _invCap = invCap;
    }

    /**
    * @dev Checks whether the _account is in the whitelist.
    * @param _account Address to be checked
    * @return Whether the _account is whitelisted
    */
    function isWhitelisted(address _account) public view returns (bool) {
        return _whitelist[_account] != 0;
    }

    /**
    * @notice function to whitelist an address which can be called only by the capper address.
    *
    * @param _account account address to be whitelisted
    * @param _phase 0: unwhitelisted, 1: whitelisted
    *
    * @return bool address is successfully whitelisted/unwhitelisted.
    */
    function updateWhitelist(address _account, uint8 _phase) external onlyCapper returns (bool) {
        require(_account != address(0));
        _updateWhitelist(_account, _phase);
        return true;
    }

    /**
    * @notice function to whitelist an address which can be called only by the capper address.
    *
    * @param _accounts list of account addresses to be whitelisted
    * @param _phase 0: unwhitelisted, 1: whitelisted
    *
    * @return bool addresses are successfully whitelisted/unwhitelisted.
    */
    function updateWhitelistAddresses(address[] _accounts, uint8 _phase) external onlyCapper {
        for (uint256 i = 0; i < _accounts.length; i++) {
            require(_accounts[i] != address(0));
            _updateWhitelist(_accounts[i], _phase);
        }
    }

    /**
    * @notice function to whitelist an address which can be called only by the capper address.
    *
    * @param _account account address to be whitelisted
    * @param _phase 0: unwhitelisted, 1: whitelisted
    */
    function _updateWhitelist(
        address _account, 
        uint8 _phase
    ) 
    internal 
    {
        if(_phase == 1){
            _whitelist[_account] = _invCap;
        } else {
            _whitelist[_account] = 0;
        }
        emit WhitelistUpdated(
            _account, 
            _phase
        );
    }

    /**
    * @dev add an address to the whitelist
    * @param _account address
    * @return true if the address was added to the whitelist, false if the address was already in the whitelist
    */
    // function addAddressToWhitelist(address _account) public onlyCapper returns (bool) {
    //     require(_account != address(0));
    //     _whitelist[_account] = _invCap;
    //     return isWhitelisted(_account);
    // }

    /**
    * @dev add addresses to the whitelist
    * @param _beneficiaries addresses
    * @return true if at least one address was added to the whitelist,
    * false if all addresses were already in the whitelist
    */
    // function addAddressesToWhitelist(address[] _beneficiaries) external onlyCapper {
    //     for (uint256 i = 0; i < _beneficiaries.length; i++) {
    //         addAddressToWhitelist(_beneficiaries[i]);
    //     }
    // }

    /**
    * @dev remove an address from the whitelist
    * @param _account address
    * @return true if the address was removed from the whitelist, false if the address wasn't already in the whitelist
    */
    // function removeAddressFromWhitelist(address _account) public onlyCapper returns (bool) {
    //     require(_account != address(0));
    //     _whitelist[_account] = 0;
    //     return isWhitelisted(_account);
    // }

    /**
    * @dev remove addresses from the whitelist
    * @param _beneficiaries addresses
    * @return true if at least one address was removed from the whitelist,
    * false if all addresses weren't already in the whitelist
    */
    // function removeAddressesFromWhitelist(address[] _beneficiaries) external onlyCapper {
    //     for (uint256 i = 0; i < _beneficiaries.length; i++) {
    //         removeAddressFromWhitelist(_beneficiaries[i]);
    //     }
    // }

    /**
    * @dev Returns the amount contributed so far by a specific _account.
    * @param _account Address of contributor
    * @return _account contribution so far
    */
    function getContribution(address _account)
    public view returns (uint256)
    {
        return _contributions[_account];
    }

    /**
    * @dev Extend parent behavior requiring purchase to respect the _account's funding cap.
    * @param _account Token purchaser
    * @param weiAmount Amount of wei contributed
    */
    function _preValidatePurchase(
        address _account,
        uint256 weiAmount
    )
    internal
    {
        super._preValidatePurchase(_account, weiAmount);
        require(
            _contributions[_account].add(weiAmount) <= _whitelist[_account]);
    }

    /**
    * @dev Extend parent behavior to update _account contributions
    * @param _account Token purchaser
    * @param weiAmount Amount of wei contributed
    */
    function _updatePurchasingState(
        address _account,
        uint256 weiAmount
    )
    internal
    {
        super._updatePurchasingState(_account, weiAmount);
        _contributions[_account] = _contributions[_account].add(weiAmount);
    }

}
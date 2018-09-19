pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Capped.sol";

contract PlazaToken is ERC20, ERC20Detailed, ERC20Mintable, ERC20Burnable, ERC20Pausable, ERC20Capped {

    /* Initializes contract with initial supply tokens to the creator of the contract */
    constructor(
        string name,
        string symbol,
        uint8 decimals,
        uint256 cap
    )
    ERC20Burnable()
    ERC20Mintable()
    ERC20Pausable()
    ERC20Capped(cap)
    ERC20Detailed(name, symbol, decimals)
    ERC20()
    public
    {}
}

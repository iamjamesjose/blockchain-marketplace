// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {

    uint public supply;
    address public founder;

    constructor() ERC20("JJCoin", "JJC") {
    }

     // mint can be called by authorised caller to mint MyToken in existence.  
    function mint(address beneficiary, uint256 mintAmount) external {
        _mint(beneficiary, mintAmount);
    }

    //replace the default 18 decimal
    function decimals() public view virtual override returns (uint8){
        return 8;
    }
}
// contracts/MyNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./erc_20.sol";

contract ERC721Contract is ERC721 {
    MyToken erc20instance;
    address public erc20address;

    constructor() ERC721("ERC721Contract", "ERC721") {
        erc20instance = new MyToken();
        erc20address = address(erc20instance);
    }

    struct ItemStructure {
        uint256 amount;
        string title;
        bool issold;
    }

    event Buy(address _from, address _to, uint256 _value, uint256 token_id);
    mapping(uint256 => ItemStructure) token_mapping;

    function createItem(address user_id, uint256 token_id) public {
        _mint(user_id, token_id);
    }

    function sellItem(uint256 token_id, uint256 amount, string memory title) public {
        require(msg.sender == ownerOf(token_id), "Only owner can sell item");
        token_mapping[token_id] = ItemStructure(amount, title, true);
    }

    function buyItem(address to_address, address from_address, uint256 token_id, uint256 token_value) public {
        // require(token_mapping[token_id].issold == true, "item can not be buy");
        erc20instance.transferFrom(to_address, from_address, token_value);
        transferFrom(from_address, to_address, token_value);
        token_mapping[token_id] = ItemStructure(
            token_mapping[token_id].amount,
            token_mapping[token_id].title,
            false
        );
        emit Buy(from_address, to_address, token_mapping[token_id].amount, token_id);
        safeTransferFrom(ownerOf(token_id), to_address, token_id);
    }

    function mintErc20() public payable {
        erc20instance.mint(msg.sender, msg.value);
    }

    function getCryptoCoinBalance(address account_address) public view returns (uint) {
        return erc20instance.balanceOf(account_address);
    }
}
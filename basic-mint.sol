// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
//Imports
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//Token Name and Symbol
contract TokenNameGoesHere is ERC20, Ownable {
    constructor() ERC20("TokenNameGoesHere", "SymbolGoesHere") {}
//Define contract owner and amount to mint
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

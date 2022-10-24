// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
//Imports - the burn variables are in ERC20Burnable.sol
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//Token attributes
contract TokenNameGoesHere is ERC20, ERC20Burnable, Ownable {
    constructor() ERC20("TokenNameGoesHere", "SymbolGoesHere") {}
//Contract owner and amount to mint
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}

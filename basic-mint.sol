// SPDX-License-Identifier: MIT
//Define minimum compiler version
pragma solidity ^0.8.4;
//Imports
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
//Token details with initial mint supply
contract TOKENNAME is ERC20 {
    constructor() ERC20("TOKANENAME", "TKN") {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }
}

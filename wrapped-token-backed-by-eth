pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

// This contract implements the ERC-20 token standard and uses the
// SafeERC20 and SafeMath libraries from OpenZeppelin for added security
contract MyToken is ERC20, SafeERC20 {
  using SafeMath for uint256;

  // The total supply of MyToken
  uint256 public totalSupply;

  // The balance of MyToken for each address
  mapping (address => uint256) public balances;

  // The constructor sets the initial supply of MyToken to 0
  constructor() public {
    totalSupply = 0;
  }

  // This function mints new MyToken by sending Ether to the contract
  function mint() public payable {
    // Check that the amount of Ether being sent is greater than 0
    require(msg.value > 0, "Value must be greater than 0");

    // Increment the total supply of MyToken and the balance of the msg.sender
    totalSupply = totalSupply.add(msg.value);
    balances[msg.sender] = balances[msg.sender].add(msg.value);
  }

  // This function redeems MyToken by sending them to the contract
  function redeem(uint256 _value) public {
    // Check that the amount of MyToken being redeemed is greater than 0
    // and that the msg.sender has a sufficient balance
    require(_value > 0, "Value must be greater than 0");
    require(balances[msg.sender] >= _value, "Insufficient balance");

    // Decrement the total supply of MyToken and the balance of the msg.sender
    totalSupply = totalSupply.sub(_value);
    balances[msg.sender] = balances[msg.sender].sub(_value);

    // Transfer the Ether back to the msg.sender
    msg.sender.transfer(_value);
  }
}

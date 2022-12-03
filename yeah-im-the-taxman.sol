pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

// This contract uses the SafeERC20 and SafeMath libraries from OpenZeppelin
// for added security and gas efficiency
contract TokenDeposit is SafeERC20 {
  using SafeMath for uint256;

  // The contract's ERC-20 token balance for each address
  mapping (address => uint256) public balances;

  // This function lets users deposit any ERC-20 token to the contract
  function deposit() public payable {
    // Check that the amount of tokens being deposited is greater than 0
    require(msg.value > 0, "Value must be greater than 0");

    // Increment the contract's token balance for the msg.sender
    balances[msg.sender] = balances[msg.sender].add(msg.value);
  }

  // This function lets users withdraw their deposited tokens,
  // but applies a 50% tax if they try to withdraw the same amount they deposited
  function withdraw(uint256 _value) public {
    // Check that the amount of tokens being withdrawn is greater than 0
    // and that the msg.sender has a sufficient balance
    require(_value > 0, "Value must be greater than 0");
    require(balances[msg.sender] >= _value, "Insufficient balance");

    // Calculate the amount of tokens to withdraw, applying a 50% tax
    // if the user is trying to withdraw the same amount they deposited
    uint256 amount = _value;
    if (_value == msg.value) {
      amount = amount.div(2);
    }

    // Decrement the contract's token balance for the msg.sender
    // and transfer the withdrawn tokens back to the msg.sender
    balances[msg.sender] = balances[msg.sender].sub(amount);
    msg.sender.transfer(amount);
  }
}

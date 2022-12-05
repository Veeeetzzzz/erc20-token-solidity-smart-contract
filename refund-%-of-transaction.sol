pragma solidity ^0.6.0;

// This is the contract for accepting deposits and sending back 1%

contract DepositSender {
    // This is the event that is triggered when a deposit is received
    event Deposit(address indexed from, uint256 amount);

    // This is the event that is triggered when 1% of the deposit is sent back
    event Fee(address indexed to, uint256 amount);

    // This function is used to accept deposits
    function () external payable {
        // First, check that the sender has sent a positive amount of ETH to the contract
        require(msg.value > 0, "Cannot accept a deposit of 0 ETH or less");

        // Calculate the amount of the 1% fee
        uint256 fee = msg.value / 100;

        // Send the 1% fee back to the sender's address
        msg.sender.transfer(fee);
        emit Fee(msg.sender, fee);

        // Trigger the Deposit event
        emit Deposit(msg.sender, msg.value);
    }
}

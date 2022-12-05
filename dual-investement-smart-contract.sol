pragma solidity ^0.5.0;

// This contract uses a price oracle to get the current price of Ether.
// You will need to replace "PriceOracle" with the name of the actual contract
// that provides the price of Ether.
contract DepositContract {
    address public owner;
    PriceOracle public priceOracle;
    uint256 public entryPrice;
    uint256 public timeLock;

    // This is the constructor that is called when the contract is deployed
    constructor() public {
        owner = msg.sender;
        // Replace "PriceOracleAddress" with the actual address of the price oracle contract
        priceOracle = PriceOracle(PriceOracleAddress);
    }

    // This function is called to deposit either USDT or ETH into the contract
    function deposit() public payable {
        // Set the entry price to the current price of Ether from the oracle
        entryPrice = priceOracle.getPrice();

        // Set the time lock to 24 hours from now
        timeLock = now + 24 hours;
    }

    // This function is called to withdraw either ETH or USDT
    function withdraw() public {
        // Check if the current time is after the time lock
        if (now >= timeLock) {
            // Check if the current price of Ether is lower than the entry price
            if (priceOracle.getPrice() < entryPrice) {
                // Return the ETH equivalent + 0.5 in ETH%
                msg.sender.transfer(msg.value + (msg.value * 0.005));
            } else {
                // Return the USDT equivalent + 0.5 in USDT
                msg.sender.transfer(msg.value + (msg.value * 0.005));
            }
        }
    }
}

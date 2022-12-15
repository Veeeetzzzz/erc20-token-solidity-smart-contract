pragma solidity ^0.6.0;

contract FractionalNFT {
    // Address of the contract owner (the "admin")
    address public owner;

    // Total supply of the NFT
    uint256 public totalSupply;

    // Price per unit of the NFT
    uint256 public pricePerUnit;

    // Mapping from user addresses to their fractional NFT balances
    mapping (address => uint256) public balances;

    // Constructor function to initialize the contract
    constructor() public {
        // Set the contract owner to the address that deployed the contract
        owner = msg.sender;
    }

    // Function to add new NFTs to the contract
    function addNFTs(uint256 _amount) public {
        // Only the contract owner can add new NFTs
        require(msg.sender == owner, "Only the contract owner can add new NFTs");

        // Update the total supply of the NFT
        totalSupply += _amount;
    }

    // Function to allow users to buy a fraction of an NFT
    function buy(uint256 _amount) public payable {
        // Check that the user is buying in 1% increments only
        require(_amount % 1 == 0, "Fractional NFTs can only be bought in 1% increments");

        // Calculate the total cost of the purchase
        uint256 totalCost = _amount * pricePerUnit;

        // Check that the user has enough balance to make the purchase
        require(msg.value >= totalCost, "Insufficient balance");

        // Check that the user is not exceeding the maximum allowed per NFT
        require(_amount + balances[msg.sender] <= 100, "Cannot exceed maximum of 100% per NFT");

        // Transfer the appropriate amount of USDT or USDC from the user's account to the contract
        require(msg.value.transfer(address(this), totalCost), "Transfer failed");

        // Update the user's fractional NFT balance
        balances[msg.sender] += _amount;
    }

    // Function to allow the user to redeem their fractional NFT for the corresponding amount of USDT or USDC
    function redeem(uint256 _amount) public {
        // Check that the user is redeeming in 1% increments only
        require(_amount % 1 == 0, "Fractional NFTs can only be redeemed in 1% increments");

        // Check that the user has enough fractional NFT balance to redeem
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Calculate the total amount of USDT or USDC to be redeemed
        uint256 totalAmount = _amount * pricePerUnit;

        // Transfer the appropriate amount of USDT or USDC from the contract to the user's account
        require(address(this).transfer(msg.sender, totalAmount), "Transfer failed");

        // Update the user's fractional NFT balance
        balances[msg.sender] -= _amount;
    }
}

pragma solidity ^0.6.0;

// This is the contract for the Burnable Wrapped Coin token

contract BurnableWrappedCoin {
    // This is the name of the token
    string public name = "Burnable Wrapped Coin";

    // This is the symbol of the token
    string public symbol = "BWRAPPED";

    // This is the number of decimals of the token
    uint8 public decimals = 18;

    // This is the total supply of the token
    uint256 public totalSupply = 0;

    // This is the balance of each account that holds the token
    mapping (address => uint256) public balanceOf;

    // This is the event that is triggered when the token is minted
    event Mint(address indexed to, uint256 amount);

    // This is the event that is triggered when the token is burned
    event Burn(address indexed from, uint256 amount);

    // This function is used to mint new tokens. It can only be called by sending ETH to the contract
    function () external payable {
        // First, check that the sender has sent the correct amount of ETH to the contract
        require(msg.value == 1 ether, "Incorrect amount of ETH sent");

        // Calculate the amount of Burnable Wrapped Coin to mint
        uint256 amount = msg.value * (10 ** uint256(decimals));

        // Mint the Burnable Wrapped Coin and send it to the sender's address
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Mint(msg.sender, amount);
    }

    // This function is used to redeem ETH from the contract by burning Burnable Wrapped Coin
    function burn(uint256 amount) public {
        // First, check that the sender has enough Burnable Wrapped Coin to burn
        require(balanceOf[msg.sender] >= amount, "Sender does not have enough Burnable Wrapped Coin to burn");

        // Check that the amount of Burnable Wrapped Coin being burned is the correct amount to redeem the ETH
        require(amount == 1 ether * (10 ** uint256(decimals)), "Incorrect amount of Burnable Wrapped Coin being burned");

        // Burn the Burnable Wrapped Coin and send the ETH to the sender's address
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        msg.sender.transfer(amount / (10 ** uint256(decimals)));
        emit Burn(msg.sender, amount);
    }
}

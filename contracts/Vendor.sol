pragma solidity 0.8.4; //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "contracts/YourToken.sol";

contract Vendor is Ownable {
    //event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

    YourToken public yourToken;

    uint256 public constant tokensPerEth = 100;

    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

    constructor(address tokenAddress) {
        yourToken = YourToken(tokenAddress);
    }

    // ToDo: create a payable buyTokens() function:
    function buyTokens() public payable returns (uint256 tokenAmount) {
        require(msg.value > 0, "not enough funds");
        uint256 amountToBuy = msg.value * tokensPerEth;

        uint256 vendorBalance = yourToken.balanceOf(address(this));
        require(
            vendorBalance >= amountToBuy,
            "vendor contract does not have enough funds"
        );

        bool sent = yourToken.transfer(msg.sender, amountToBuy);
        require(sent, "failed to transfer to user");

        emit BuyTokens(msg.sender, msg.value, amountToBuy);
        return amountToBuy;
    }

    // ToDo: create a withdraw() function that lets the owner withdraw ETH

    function withdraw() public onlyOwner {
        //owner has enough balance
        uint256 ownerBalance = address(this).balance;
        require(ownerBalance > 0, "not neough funds");

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "failed to send back to user");
    }

    // ToDo: create a sellTokens(uint256 _amount) function:
    function sellTokens(uint256 tokenAmountToSell) public {
        //verify requested amount to sell > 0
        require(tokenAmountToSell > 0, "token amount to sell needs to be >0");

        //verify user token balance is enough for a swap
        uint256 userBalance = yourToken.balanceOf(msg.sender);
        require(
            userBalance >= tokenAmountToSell,
            "your balance is lower than amount of tokens to sell"
        );

        uint256 amountOfETHToTransfer = tokenAmountToSell / tokensPerEth;
        uint256 ownerETHBalance = address(this).balance;
        require(
            ownerETHBalance >= amountOfETHToTransfer,
            "vendor does not have enough funds for the sell"
        );

        bool sent = yourToken.transferFrom(
            msg.sender,
            address(this),
            tokenAmountToSell
        );
        require(sent, "failed to send ETH to user");

        (sent, ) = msg.sender.call{value: amountOfETHToTransfer}("");
        require(sent, "Failed to send ETH to user");
    }
}

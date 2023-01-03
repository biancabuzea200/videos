// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EtherWallet {
    //owner
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    //receive()
    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
    }

    //getBalance()
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}

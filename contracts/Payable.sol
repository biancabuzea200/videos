// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Payable {
    //addr that can receive Ether
    address payable public owner;

    constructor() payable {
        owner = payable(msg.sender);
    }

    //deposit ether into the contract
    function deposit() public payable {}

    function notPayable() public {}

    //withdraw
    function withdraw() public {
        uint amount = address(this).balance;
        (bool success, ) = owner.call{value: amount}("");
        require(success, "failed to send ether");
    }

    //transfer
    function transfer(address payable _to, uint _amount) public {
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "failed to send Ether");
    }
}

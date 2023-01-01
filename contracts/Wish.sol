// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Wish {
    string public wish;

    function setWish() public returns (string memory) {
        wish = "Happyy New Year!";
        return wish;
    }
}

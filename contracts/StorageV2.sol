// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageV2 {
    uint public val;

    function inc() external {
        val++;
    }
}
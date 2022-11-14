// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Storage {
    uint public val;

    // аналог конструктора
    function initialize(uint _newVal) external {
        val = _newVal;
    }
}
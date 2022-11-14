// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// обновленная версия токена
contract TransparUUPSTokenV2 is Initializable, ERC20Upgradeable, OwnableUpgradeable, UUPSUpgradeable {
    // в апгрейде мы не пишем функцию initialize, только единожды
    function mint(address to, uint amount) external onlyOwner {
        _mint(to, amount * 2);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
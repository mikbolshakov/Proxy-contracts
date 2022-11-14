// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

// первоначальная версия токена
contract TransparUUPSToken is Initializable, ERC20Upgradeable, OwnableUpgradeable, UUPSUpgradeable {

    // с помощью initializer эту функцию вызываем только один раз
    function initialize() external initializer {
        __ERC20_init("TransparUUPSToken", "TUT"); // то же самое, что и конструктор, только другое название
        __Ownable_init();
        __UUPSUpgradeable_init();
    }

    function mint(address to, uint amount) external onlyOwner {
        _mint(to, amount);
    }

    // функция для UUPSUpgradeable - указываем, кто может делать апгрейд (владелец контракта)
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
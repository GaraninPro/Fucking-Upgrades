//SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.18;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract BoxV2 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;
    string internal name;

    function setNumber(uint256 _number) external {
        number = _number;
    }

    function setName(string memory _name) external {
        name = _name;
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function getName() external view returns (string memory) {
        return name;
    }

    function getVersion() external pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}

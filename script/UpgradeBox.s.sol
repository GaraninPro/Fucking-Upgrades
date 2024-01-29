//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/Boxv2.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        address mostRecentDeployedProxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();

        BoxV2 newBox = new BoxV2();

        vm.stopBroadcast();

        address proxy = updateBox(mostRecentDeployedProxy, address(newBox));

        return proxy;
    }

    function updateBox(address proxyAddress, address newImplementationContract) public returns (address) {
        vm.startBroadcast();

        BoxV1 proxy = BoxV1(payable(proxyAddress));

        // bytes memory initData = abi.encodeWithSignature("getName()");

        proxy.upgradeTo(address(newImplementationContract));

        vm.stopBroadcast();

        return address(proxy);
    }
}

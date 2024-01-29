//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/Boxv2.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox public deployBox;
    UpgradeBox public upgradeBox;

    function setUp() public {
        deployBox = new DeployBox();

        upgradeBox = new UpgradeBox();
    }

    function testBoxWorks() public {
        address proxy = deployBox.run();

        uint256 expectedValue = 1;

        assertEq(expectedValue, BoxV1(proxy).getVersion());
    }

    function testDeployIsV1() public {
        address proxy = deployBox.run();

        uint256 value = 5;
        vm.expectRevert();

        BoxV2(proxy).setNumber(value);
    }

    function testUpgradeWorks() public {
        address proxy = deployBox.run();
        console.log("I am a proxy owner:", BoxV1(proxy).owner());
        console.log("I am a msg.sender:", msg.sender);
        BoxV2 newBox = new BoxV2();

        //  vm.prank(BoxV1(proxy).owner());
        // BoxV1(proxy).transferOwnership(msg.sender);

        // BoxV1(proxy).upgradeToAndCall(address(newBox), "");

        upgradeBox.updateBox(address(proxy), address(newBox));

        uint256 versionValue = 2;

        assertEq(versionValue, BoxV2(proxy).getVersion());

        uint256 number = 234;
        BoxV2(proxy).setNumber(number);
        assertEq(number, BoxV2(proxy).getNumber());

        console.log("I am a proxy address:", address(proxy));

        console.log("I am a deployBox address:", address(deployBox));
    }
}

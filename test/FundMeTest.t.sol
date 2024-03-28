// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    function setUp() external {
        fundMe = new FundMe();
    }

    function test_minimum_usd_is_3() public view {
        assertEq(fundMe.MINIMUM_USD(), 3e18);
    }

    function test_sender_is_contract_owner() public view {
        assertEq(fundMe.i_owner(), address(this));
    }

    function test_price_version_is_4() public view {
        assertEq(fundMe.getVersion(), 4);
    }
}
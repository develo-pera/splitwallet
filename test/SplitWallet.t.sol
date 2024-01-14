// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SplitWallet} from "../src/SplitWallet.sol";

contract CounterTest is Test {
    SplitWallet public splitWallet;

    function setUp() public {
        splitWallet = new SplitWallet();
    }

    function test_CreateDebt() public {
        address testDebtor = address(0x123);
        uint256 testAmount = 100;

        splitWallet.createDebt(testDebtor, testAmount);

        (uint256 amount, address creditor, address debtor , bool paid,) = splitWallet.debts(0);

        assertEq(testAmount, amount);
        assertEq(address(this), creditor);
        assertEq(testDebtor, debtor);
        assertEq(false, paid);
    }

    function test_RepayDebt() public {
        address testDebtor = address(0x123);
        uint256 testAmount = 100;

        splitWallet.createDebt(testDebtor, testAmount);
        splitWallet.repayDebt(0);

        (uint256 amount, address creditor, address debtor , bool paid,) = splitWallet.debts(0);

        assertEq(testAmount, amount);
        assertEq(address(this), creditor);
        assertEq(testDebtor, debtor);
        assertEq(true, paid);
    }
}

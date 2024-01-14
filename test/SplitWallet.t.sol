// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SplitWallet} from "../src/SplitWallet.sol";

contract SplitWalletTest is Test {
    SplitWallet public splitWallet;

    function setUp() public {
        splitWallet = new SplitWallet();
    }

    function test_CreateDebt() public {
        address[] memory testDebtorsArray = new address[](1);
        testDebtorsArray[0] = address(0x123);
        uint256 testAmount = 100;

        (uint256 debtsGroupId) = splitWallet.createDebtGroup(testDebtorsArray, testAmount);

        (uint256 amount, address creditor, address debtor , bool paid,) = splitWallet.debtsGroup(debtsGroupId, 0);

        assertEq(testAmount, amount);
        assertEq(address(this), creditor);
        assertEq(testDebtorsArray[0], debtor);
        assertEq(false, paid);
    }

    function test_RepayDebt() public {
        // address[] memory testDebtorAddreses = [0x123];
        // uint256 testAmount = 100;

        // (uint256 groupId,) = splitWallet.createDebtGroup(testDebtorAddreses, testAmount);
        // splitWallet.repayDebt(groupId);
        // SplitWallet.Debt[] storage debts = splitWallet.debtsGroup(groupId);
        
        // for (uint256 i = 0; i < debts.length; i++) {
        //     if (debts[i].debtor == msg.sender) {
        //         assertEq(true, debts[i].paid);
        //         return;
        //     }
        // }

        // assertEq(testAmount, amount);
        // assertEq(address(this), creditor);
        // assertEq(testDebtor, debtor);
        // assertEq(true, paid);
    }
}

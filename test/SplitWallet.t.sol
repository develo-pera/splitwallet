// // SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.13;

// import {Test, console2} from "forge-std/Test.sol";
// import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
// import {SplitWallet} from "../src/SplitWallet.sol";

// contract SplitWalletTest is Test {
//     SplitWallet public splitWallet;

//     function setUp() public {
//         splitWallet = new SplitWallet();
//     }

//     function test_CreateDebt() public {
//         address[] memory testDebtorsArray = new address[](1);
//         testDebtorsArray[0] = address(0x123);
//         uint256 testAmount = 100;

//         uint256 debtsGroupId = splitWallet.createDebtGroup(testDebtorsArray, testAmount);

//         SplitWallet.Debt[] memory debts = splitWallet.getDebtsGroup(debtsGroupId);
//         assertEq(debts.length, 1);

//         assertEq(debts[0].debtor, testDebtorsArray[0]);
//         assertEq(debts[0].amount, testAmount);
//         assertEq(debts[0].paid, false);
//         assertEq(debts[0].creditor, address(this));
//     }

//     function test_RepayDebt() public {
//         address[] memory testDebtorsArray = new address[](1);
//         testDebtorsArray[0] = address(this);
//         uint256 testAmount = 100;

//         uint256 groupId = splitWallet.createDebtGroup(testDebtorsArray, testAmount);
//         splitWallet.repayDebt(groupId);
//         SplitWallet.Debt[] memory debts = splitWallet.getDebtsGroup(groupId);
//         assertEq(debts.length, 1);

//         for (uint256 i = 0; i < debts.length; i++) {
//             if (debts[i].debtor == msg.sender) {
//                 assertEq(true, debts[i].paid);
//                 assertEq(debts[i].creditor, address(this));
//                 assertEq(debts[i].amount, testAmount);
//                 break;
//             }
//         }
//     }

//     function test_RepayDebt_WhenCallerNotInDebtorsList() public {
//        address[] memory testDebtorsArray = new address[](1);
//         testDebtorsArray[0] = address(0x123);
//         uint256 testAmount = 100;

//         uint256 groupId = splitWallet.createDebtGroup(testDebtorsArray, testAmount);
//         vm.expectRevert("No debt found for this debtor");
//         splitWallet.repayDebt(groupId); 
//     }
// }

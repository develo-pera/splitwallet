// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract SplitWallet {
    uint256 debtGroupIdCounter;
    IERC20 ghoToken;

    struct Debt {
        uint256 amount;
        address creditor;
        address debtor;
        bool paid;
        bytes32 metadata;
    }

    mapping(uint256 debtsGroupId => Debt[]) debtsGroup;

    event CreateDebt(address indexed creditor, address indexed debtor, uint256 amount);
    event CreateDebtGroup(uint256 indexed groupId, address indexed creditor, address[] indexed debtors, uint256 amount);

    constructor(address _ghoToken) {
        ghoToken = IERC20(_ghoToken);
    }

    function getTotalSupply() public view returns (uint256) {
        return ghoToken.totalSupply();
    }

    function getDebtsGroup(uint256 groupId) public view returns (Debt[] memory) {
        return debtsGroup[groupId];
    }

    function addDebtToGroup(uint256 groupId, address debtor, uint256 amount) internal {
        debtsGroup[groupId].push(Debt(amount, msg.sender, debtor, false, ""));
        emit CreateDebt(msg.sender, debtor, amount);
    }

    function createDebtGroup(address[] memory debtors, uint256 totalAmount) public returns (uint256 debtsGroupId) {
        uint256 newGroupId = debtGroupIdCounter;
        for (uint256 i = 0; i < debtors.length; i++) {
            addDebtToGroup(newGroupId, debtors[i], totalAmount);
        }

        emit CreateDebtGroup(newGroupId, msg.sender, debtors, totalAmount);

        debtGroupIdCounter++;

        return newGroupId;
    }

    // Loop through all debts in the group, find msg.sender eq debtor, and mark it as paid.
    // Make it payable so we can send ERC20 tokens to it. Use ERC20.transferFrom to send tokens to this contract.
    // @dev v2 use account abstraction in order to avoind users having to approve this contract to spend their tokens
    function repayDebt(uint256 _debtsGroupId) public {
        Debt[] storage s_debts = debtsGroup[_debtsGroupId];

        for (uint256 i = 0; i < s_debts.length; i++) {
            if (s_debts[i].debtor == msg.sender) {
                s_debts[i].paid = true;
                return;
            }
        }
        
        revert("No debt found for this debtor");
    }
}

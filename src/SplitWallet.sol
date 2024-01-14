// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SplitWallet {
    uint256 counter;
    struct Debt {
        uint256 amount;
        address creditor;
        address debtor;
        bool paid;

        bytes32 metadata;
    }

    // mapping(address => Debt) public debts;
    mapping(uint256 => Debt) public debts;

    event CreateDebt(address indexed creditor, address indexed debtor, uint256 amount);

    function createDebt(address debtor, uint256 amount) public {
        debts[counter] = Debt(amount, msg.sender, debtor, false, "");
        counter++;
        emit CreateDebt(msg.sender, debtor, amount);
    }

    function repayDebt(uint256 debtId) public {
        Debt storage debt = debts[debtId];
        debt.paid = true;
    }
}

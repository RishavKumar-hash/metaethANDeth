// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address payable public owner;
    uint256 public balance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);

    constructor(uint256 initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function deposit(uint256 _amount) public payable {
        uint256 previousBalance = balance;

        // Ensure the caller is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // Perform deposit
        balance += _amount;

        // Ensure the deposit was successful
        assert(balance == previousBalance + _amount);

        // Emit deposit event
        emit Deposit(_amount);
    }

    // Custom error for insufficient balance
    error InsufficientBalance(uint256 currentBalance, uint256 requestedAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");

        uint256 previousBalance = balance;

        // Check for sufficient balance
        if (balance < _withdrawAmount) {
            revert InsufficientBalance(balance, _withdrawAmount);
        }

        // Perform withdrawal
        balance -= _withdrawAmount;

        // Ensure the withdrawal was successful
        assert(balance == previousBalance - _withdrawAmount);

        // Emit withdrawal event
        emit Withdraw(_withdrawAmount);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Escrow {
    address public buyer;
    address public seller;

    bool public isDeposited;
    bool public isShipped;
    bool public isCompleted;

    constructor(address _seller) {
        buyer = msg.sender;
        seller = _seller;
    }

    function deposit() external payable {
        require(msg.sender == buyer, "Only buyer");
        require(!isDeposited, "Already deposited");

        isDeposited = true;
    }

    function markAsShipped() external {
        require(msg.sender == seller, "Only seller");
        require(isDeposited, "No deposit yet");
        require(!isShipped, "Already shipped");

        isShipped = true;
    }

    function confirmDelivery() external {
        require(msg.sender == buyer, "Only buyer");
        require(isShipped, "Not shipped yet");
        require(!isCompleted, "Already completed");

        isCompleted = true;
        payable(seller).transfer(address(this).balance);
    }

    function refund() external {
        require(msg.sender == buyer, "Only buyer");
        require(isDeposited, "No deposit");
        require(!isCompleted, "Already completed");

        payable(buyer).transfer(address(this).balance);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 1: Storing Owner
contract Contract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }
}
// 2: Receive Ether
contract Contract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

      receive() external payable {
        
    }
}
// 3: Tip Owner
contract Contract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

      receive() external payable {
        // contract can now receive ETH without calldata
    }

    function tip() public payable {
        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Transfer failed");
    }
}

// 4: Charity
contract Contract {
    address public owner;
    address public charity; 

    constructor(address _charity) { 
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {
        // contract can now receive ETH without calldata
    }

    function tip() public payable {
        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Transfer failed");
    }

    function donate() external {
        uint balance = address(this).balance;
        (bool success, ) = charity.call{value: balance}("");
        require(success, "Donation failed");
    }
}
// 5: Self Destruct

contract Contract {
    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {
        // contract can now receive ETH without calldata
    }

    function tip() public payable {
        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Transfer failed");
    }

    function donate() external {
        selfdestruct(payable(charity));
    }
}
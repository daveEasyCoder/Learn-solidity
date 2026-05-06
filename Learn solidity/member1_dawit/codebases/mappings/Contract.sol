// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


// 1: Add Member
contract Contract {
    mapping(address => bool) public members;

    function addMember(address user) external {
        members[user] = true;
    }
}

// 2: Is Member
contract Contract {
    mapping(address => bool) public members;

    function addMember(address user) external {
        members[user] = true;
    }

    function isMember(address user) external view returns (bool) {
        return members[user];
    }
}

// 3: Remove Member
contract Contract {
    mapping(address => bool) public members;

    function addMember(address user) external {
        members[user] = true;
    }

    function isMember(address user) external view returns (bool) {
        return members[user];
    }

    function removeMember(address user) external {
        members[user] = false;
    }
}

// 4: Map Structs

contract Contract {
    struct User {
        uint balance;
        bool isActive;
    }

    mapping(address => User) public users;

    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");

        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }
}

// 5: Map Structs 2

contract Contract {
    struct User {
        uint balance;
        bool isActive;
    }

    mapping(address => User) public users;

    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");

        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }

    function transfer(address to, uint amount) external {
        require(users[msg.sender].isActive, "Sender not active");
        require(users[to].isActive, "Recipient not active");
        require(users[msg.sender].balance >= amount, "Insufficient balance");

        users[msg.sender].balance -= amount;
        users[to].balance += amount;
    }
}

// 6: Nested Maps
contract Contract {
    enum ConnectionTypes { 
        Unacquainted,
        Friend,
        Family
    }
    
    mapping(address => mapping(address => ConnectionTypes)) public connections;

    function connectWith(address other, ConnectionTypes connectionType) external {
        connections[msg.sender][other] = connectionType;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 1: Add Member
contract Contract {
    mapping(address => bool) public members;

    function addMember(address newMember) external {
        members[newMember] = true;
    }
}

// 2: Is Member
contract Contract {
    mapping(address => bool) public members;

    function addMember(address newMember) external {
        members[newMember] = true;
    }

    function isMember(address addr) external view returns (bool) {
        return members[addr];
    }
}

// 3: Remove Member
contract Contract {
    mapping(address => bool) public members;

    function addMember(address newMember) external {
        members[newMember] = true;
    }

    function isMember(address addr) external view returns (bool) {
        return members[addr];
    }

    function removeMember(address addr) external {
        members[addr] = false;
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
        require(!users[msg.sender].isActive);
        users[msg.sender] = User(100, true);
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
        require(!users[msg.sender].isActive);
        users[msg.sender] = User(100, true);
    }

    function transfer(address recipient, uint amount) external {
        require(users[msg.sender].isActive);
        require(users[recipient].isActive);
        require(users[msg.sender].balance >= amount);

        users[msg.sender].balance -= amount;
        users[recipient].balance += amount;
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

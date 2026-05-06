// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// 1: Fixed Sum
contract Contract {
    function sum(uint[5] memory numbers) external pure returns (uint) {
        uint total = 0;
        for (uint i = 0; i < 5; i++) {
            total += numbers[i];
        }
        return total;
    }
}

// 2: Dynamic Sum
contract Contract {
    function sum(uint[] calldata numbers) external pure returns (uint) {
        uint total = 0;
        for (uint i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }
        return total;
    }
}

// 3: Filter to Storage
contract Contract {
    uint[] public evenNumbers;

    function filterEven(uint[] calldata numbers) external {
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evenNumbers.push(numbers[i]);
            }
        }
    }
}

// 4: Filter to Memory
contract Contract {
    function filterEven(uint[] calldata numbers) external pure returns (uint[] memory) {
        uint count = 0;
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                count++;
            }
        }

        uint[] memory evens = new uint[](count);
        uint idx = 0;
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evens[idx] = numbers[i];
                idx++;
            }
        }

        return evens;
    }
}

// 5: Stack Club 1
contract StackClub {
    address[] public members;

    function addMember(address newMember) external {
        members.push(newMember);
    }

    function isMember(address addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == addr) {
                return true;
            }
        }
        return false;
    }
}

// 6: Stack Club 2
contract StackClub {
    address[] public members;

    constructor() {
        members.push(msg.sender);
    }

    modifier onlyMember() {
        require(isMember(msg.sender));
        _;
    }

    function addMember(address newMember) external onlyMember {
        members.push(newMember);
    }

    function removeLastMember() external onlyMember {
        members.pop();
    }

    function isMember(address addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == addr) {
                return true;
            }
        }
        return false;
    }
}

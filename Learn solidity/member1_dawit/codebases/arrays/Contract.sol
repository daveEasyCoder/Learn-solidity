// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;


// 1: Fixed Sum
contract Contract {
    function sum(uint[5] memory nums) external pure returns (uint) {
        uint total = 0;

        for (uint i = 0; i < 5; i++) {
            total += nums[i];
        }

        return total;
    }
}

// 2: Dynamic Sum
contract Contract {
    function sum(uint[] memory nums) external pure returns (uint) {
        uint total = 0;

        for (uint i = 0; i < nums.length; i++) {
            total += nums[i];
        }

        return total;
    }
}

// 3: Filter to Storage

contract Contract {
    uint[] public evenNumbers;

    function filterEven(uint[] calldata nums) external {
        for (uint i = 0; i < nums.length; i++) {
            if (nums[i] % 2 == 0) {
                evenNumbers.push(nums[i]);
            }
        }
    }
}

// 4: Filter to Memory

contract Contract {
    function filterEven(uint[] calldata nums)
        external
        pure
        returns (uint[] memory)
    {
        uint count = 0;

        
        for (uint i = 0; i < nums.length; i++) {
            if (nums[i] % 2 == 0) {
                count++;
            }
        }

        uint[] memory evens = new uint[](count);

        uint index = 0;
        for (uint i = 0; i < nums.length; i++) {
            if (nums[i] % 2 == 0) {
                evens[index] = nums[i];
                index++;
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

    function isMember(address user) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == user) {
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

    function isMember(address user) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == user) {
                return true;
            }
        }
        return false;
    }

    function addMember(address newMember) external {
        require(isMember(msg.sender), "Not a member");
        members.push(newMember);
    }

    function removeLastMember() external {
        require(isMember(msg.sender), "Not a member");
        require(members.length > 0, "No members");

        members.pop();
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//Array 1

contract Contract { 
    function sum(uint[5] calldata numbers) external pure returns (uint) {
        uint total = 0;
        for (uint i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }
        return total;
    }
}

//Array 2

contract Contract {

    function sum(uint[] calldata numbers) external pure returns (uint) {
        uint total = 0;

        
        for (uint i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }

        return total;
    }
}
//Array 3

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

//Array 4

contract Contract {

    function filterEven(uint[] calldata numbers) external pure returns (uint[] memory) {
        uint evenCount = 0;

        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evenCount++;
            }
        }

        uint[] memory evens = new uint[](evenCount);
        uint currentIndex = 0;

        
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evens[currentIndex] = numbers[i];
                currentIndex++;
            }
        }

        return evens;
    }
}

//Array 5


contract StackClub {
    
    address[] public members;


    function addMember(address _newMember) external {
        members.push(_newMember);
    }

 
    function isMember(address _addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == _addr) {
                return true;
            }
        }
        return false;
    }
}

//Array 6

contract StackClub {
    address[] public members;

    constructor() {
        
        members.push(msg.sender);
    }

    function addMember(address _newMember) external {
        
        require(isMember(msg.sender), "Caller is not a member");
        members.push(_newMember);
    }

    function removeLastMember() external {
        
        require(isMember(msg.sender), "Caller is not a member");
        
        require(members.length > 0, "No members to remove");
        
        members.pop();
    }

    function isMember(address _addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == _addr) {
                return true;
            }
        }
        return false;
    }
}
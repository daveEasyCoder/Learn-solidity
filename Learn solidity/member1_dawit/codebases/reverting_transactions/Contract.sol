// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;



// 1: Constructor Revert
contract Contract {
    constructor() payable {
        require(msg.value >= 1 ether, "Must send at least 1 ether");
    }
}

// 2: Only Owner

contract Contract {

    address public owner;

    constructor() payable {
        require(msg.value >= 1 ether, "Must send at least 1 ether");
        owner = msg.sender;
    }

    function withdraw() public {
        require(msg.sender == owner, "Not owner");

        uint balance = address(this).balance;
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Transfer failed");
    }
}

// 3: Owner Modifier

contract Contract {
	uint configA;
	uint configB;
	uint configC;
	address owner;

	constructor() {
		owner = msg.sender;
	}

	function setA(uint _configA) public onlyOwner {
		configA = _configA;
	}

	function setB(uint _configB) public onlyOwner {
		configB = _configB;
	}

	function setC(uint _configC) public onlyOwner {
		configC = _configC;
	}

	modifier onlyOwner {
		require(msg.sender == owner, "Not owner");
		_;
	}
}
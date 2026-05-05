// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 1: Booleans
contract Contract {
	bool public a = true;
    bool public b = false;
}


// 2: Unsigned Integers 
contract Contract {
    uint8 public a = 120;    
    uint16 public b = 300;   
    uint256 public sum = uint256(a) + uint256(b);
}


// 3: Signed Integers 
contract Contract {
    int8 public a = 50;    
    int8 public b = -30;  

    int16 public difference = int16(a - b >= 0 ? a - b : b - a);
}

// 4: String Literals
contract Contract {
	bytes32 public msg1 = "Hello World"; 
    string public msg2 = "Hello World from Solidity programming world";
}

// 5: Enum
contract Contract {
    enum Foods { Apple, Pizza, Bagel, Banana }

	Foods public food1 = Foods.Apple;
	Foods public food2 = Foods.Pizza;
	Foods public food3 = Foods.Bagel;
	Foods public food4 = Foods.Banana;
}

// Arguments
contract Contract {
    uint public x;
    constructor(uint _x) {
        x = _x;
    }
}

// Increment
contract Contract {
    uint public x;
    constructor(uint _x) {
        x = _x;
    }
    function increment() external {
        x += 1;
    }
}

// View Addition
contract Contract {
    uint public x;
    constructor(uint _x) {
        x = _x;
    }
    function increment() external {
        x += 1;
    }
    function add(uint _value) external view returns(uint) {
        return x + _value;
    }
}

// Console Log
contract Contract {
    function winningNumber(string calldata secretMessage) external returns(uint) {
        console.log(secretMessage);
        return 794;
    }
}

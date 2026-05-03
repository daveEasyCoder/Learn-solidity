// 1: Arguments
contract Contract {

    uint public x;

    constructor(uint _x) {
        x = _x;
    }

}

// 2: Increment

contract Contract {

    uint public x;

    constructor(uint _x) {
        x = _x;
    }
    function increment() external {
        x += 1;
    }

}

// 3: View Addition
contract Contract {

    uint public x;

    constructor(uint _x) {
        x = _x;
    }
    function increment() external {
        x += 1;
    }

    function add(uint _value) external view returns (uint) {
        return x + _value;
    }

}

// 4: Console Log
import "forge-std/console.sol";

contract Contract {
    function winningNumber(string calldata secretMessage) external returns(uint) {
        console.log(secretMessage);
        return 794;
    }
}

// 5: Pure Double
contract Contract {
    function double(uint _value) external pure returns (uint) {
        return _value * 2;
    }
}

// 6: Double Overload
contract Contract {

    function double(uint _value) public pure returns (uint) {
        return _value * 2;
    }

    function double(uint _a, uint _b) external pure returns (uint, uint) {
        return (_a * 2, _b * 2);
    }

}
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

    receive() external payable {}
}

// 3: Tip Owner
contract Contract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function tip() public payable {
        (bool s, ) = owner.call{ value: msg.value }("");
        require(s);
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

    receive() external payable {}

    function donate() public {
        (bool s, ) = charity.call{ value: address(this).balance }("");
        require(s);
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

    receive() external payable {}

    function donate() public {
        selfdestruct(payable(charity));
    }
}

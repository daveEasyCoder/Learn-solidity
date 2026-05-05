Inheritance 1

import "./Hero.sol";

contract Mage is Hero {
    
}

contract Warrior is Hero {
    
}


Inheritance 2

import "./Hero.sol";


contract Mage is Hero(50) {
    
}

contract Warrior is Hero(200) {
    
}


Inheritance 3

import "./Hero.sol";

contract Mage is Hero(50) {
    
    function attack(Enemy _enemy) override public {
        _enemy.takeAttack(AttackTypes.Spell);
    }
}

contract Warrior is Hero(200) {
    
    function attack(Enemy _enemy) override public {
        _enemy.takeAttack(AttackTypes.Brawl);
    }
}


Inheritance 4

import "./Hero.sol";

contract Mage is Hero(50) {
    function attack(Enemy _enemy) override public {
        _enemy.takeAttack(AttackTypes.Spell);
        
        super.attack(_enemy);
    }
}

contract Warrior is Hero(200) {
    function attack(Enemy _enemy) override public {
        _enemy.takeAttack(AttackTypes.Brawl);
      
        super.attack(_enemy);
    }
}


Inheritance 5

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
}


Inheritance 6

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
}

contract Transferable is Ownable {
    function transfer(address _newOwner) external onlyOwner {
        owner = _newOwner;
    }
}

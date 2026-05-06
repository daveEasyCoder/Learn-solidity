// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";


// 1: Inherit
contract Mage is Hero {
    // inherits everything from Hero
}

contract Warrior is Hero {
    // inherits everything from Hero
}

// 2: Constructor Args
contract Mage is Hero(50) {
    // Mage starts with 50 health
}

contract Warrior is Hero(200) {
    // Warrior starts with 200 health
}

// 3: Virtual Override
contract Mage is Hero(50) {

    function attack(Enemy enemy) public override {
        enemy.takeAttack(AttackTypes.Spell);
    }
}

contract Warrior is Hero(200) {

    function attack(Enemy enemy) public override {
        enemy.takeAttack(AttackTypes.Brawl);
    }
}

// 4: Super

contract Mage is Hero(50) {

    function attack(Enemy enemy) public override {
        enemy.takeAttack(AttackTypes.Spell);
        super.attack(enemy);
    }
}

contract Warrior is Hero(200) {

    function attack(Enemy enemy) public override {
        enemy.takeAttack(AttackTypes.Brawl);
        super.attack(enemy);
    }
}


// 5: Ownable

contract Ownable {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
}

// 6: Multiple Inheritance
contract Ownable {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
}

contract Transferable is Ownable {

    function transfer(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
}
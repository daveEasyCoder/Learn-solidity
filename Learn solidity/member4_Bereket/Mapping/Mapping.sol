Mapping 1

contract Contract {
    mapping(address => bool) public members;

    function addMember(address _addr) external {
        members[_addr] = true;
    }
}


Mapping 2

contract Contract {
    mapping(address => bool) public members;

    function addMember(address _addr) external {
        members[_addr] = true;
    }

    function isMember(address _addr) external view returns (bool) {
        return members[_addr];
    }
}

Mapping 3

contract Contract {
    mapping(address => bool) public members;

    function addMember(address _addr) external {
        members[_addr] = true;
    }

    function isMember(address _addr) external view returns (bool) {
        return members[_addr];
    }

    function removeMember(address _addr) external {
        members[_addr] = false;
    }
}

Mapping 4

contract Contract {
    struct User {
        uint balance;
        bool isActive;
    }

    mapping(address => User) public users;

    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");

        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }
}

Mapping 5

contract Contract {
    struct User {
        uint balance;
        bool isActive;
    }

    mapping(address => User) public users;

    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");
        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }

    function transfer(address _recipient, uint _amount) external {
        require(users[msg.sender].isActive, "Sender must be active");
        require(users[_recipient].isActive, "Recipient must be active");
        require(users[msg.sender].balance >= _amount, "Insufficient balance");

        users[msg.sender].balance -= _amount;
        users[_recipient].balance += _amount;
    }
}

Mapping 6

contract Contract {
    enum ConnectionTypes { 
        Unacquainted, 
        Friend, 
        Family, 
        Spouse 
    }

    mapping(address => mapping(address => ConnectionTypes)) public connections;

    function connectWith(address other, ConnectionTypes connectionType) external {
        connections[msg.sender][other] = connectionType;
    }
}

Voting 1


contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));
    }
}




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

Voting 2

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

    function castVote(uint _proposalId, bool _supports) external {
        Proposal storage proposal = proposals[_proposalId];

        if (_supports) {
            proposal.yesCount++;
        } else {
            proposal.noCount++;
        }
    }
}

voting 3

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    
    mapping(uint => mapping(address => bool)) private receipts;
    
    mapping(uint => mapping(address => bool)) private hasVoted;

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));
    }

    function castVote(uint _proposalId, bool _supports) external {
        Proposal storage proposal = proposals[_proposalId];

        if (hasVoted[_proposalId][msg.sender]) {
           
            if (receipts[_proposalId][msg.sender] != _supports) {
                if (_supports) {
                    
                    proposal.noCount--;
                    proposal.yesCount++;
                } else {
                   
                    proposal.yesCount--;
                    proposal.noCount++;
                }
            } else {
                return;
            }
        } else {
           
            if (_supports) {
                proposal.yesCount++;
            } else {
                proposal.noCount++;
            }
            hasVoted[_proposalId][msg.sender] = true;
        }

        
        receipts[_proposalId][msg.sender] = _supports;
    }
}


voting 4

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    mapping(uint => mapping(address => bool)) private receipts;
    mapping(uint => mapping(address => bool)) private hasVoted;

    function newProposal(address _target, bytes calldata _data) external {
        uint proposalId = proposals.length;
        
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));

        emit ProposalCreated(proposalId);
    }

    function castVote(uint _proposalId, bool _supports) external {
        require(_proposalId < proposals.length, "Index out of bounds");
        Proposal storage proposal = proposals[_proposalId];

        if (hasVoted[_proposalId][msg.sender]) {
            if (receipts[_proposalId][msg.sender] != _supports) {
                if (_supports) {
                    proposal.noCount--;
                    proposal.yesCount++;
                } else {
                    proposal.yesCount--;
                    proposal.noCount++;
                }
                receipts[_proposalId][msg.sender] = _supports;
            }
            // Removed the "return" so the event always fires
        } else {
            if (_supports) {
                proposal.yesCount++;
            } else {
                proposal.noCount++;
            }
            hasVoted[_proposalId][msg.sender] = true;
            receipts[_proposalId][msg.sender] = _supports;
        }

        emit VoteCast(_proposalId, msg.sender);
    }
}


voting 5

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;
    mapping(address => bool) public members;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    mapping(uint => mapping(address => bool)) private receipts;
    mapping(uint => mapping(address => bool)) private hasVoted;

    constructor(address[] memory _members) {
        for(uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
        members[msg.sender] = true;
    }

    function newProposal(address _target, bytes calldata _data) external {
        require(members[msg.sender], "Not a authorized member");
        
        uint proposalId = proposals.length;
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));

        emit ProposalCreated(proposalId);
    }

    function castVote(uint _proposalId, bool _supports) external {
        require(members[msg.sender], "Not a authorized member");
        require(_proposalId < proposals.length, "Index out of bounds");
        
        Proposal storage proposal = proposals[_proposalId];

        if (hasVoted[_proposalId][msg.sender]) {
            if (receipts[_proposalId][msg.sender] != _supports) {
                if (_supports) {
                    proposal.noCount--;
                    proposal.yesCount++;
                } else {
                    proposal.yesCount--;
                    proposal.noCount++;
                }
                receipts[_proposalId][msg.sender] = _supports;
            }
        } else {
            if (_supports) {
                proposal.yesCount++;
            } else {
                proposal.noCount++;
            }
            hasVoted[_proposalId][msg.sender] = true;
            receipts[_proposalId][msg.sender] = _supports;
        }

        emit VoteCast(_proposalId, msg.sender);
    }
}

Mapping 6

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed;
    }

    Proposal[] public proposals;
    mapping(address => bool) public members;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    mapping(uint => mapping(address => bool)) private receipts;
    mapping(uint => mapping(address => bool)) private hasVoted;

    constructor(address[] memory _members) {
        for(uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
        members[msg.sender] = true;
    }

    function newProposal(address _target, bytes calldata _data) external {
        require(members[msg.sender], "Not an authorized member");
        
        uint proposalId = proposals.length;
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0,
            executed: false
        }));

        emit ProposalCreated(proposalId);
    }

    function castVote(uint _proposalId, bool _supports) external {
        require(members[msg.sender], "Not an authorized member");
        require(_proposalId < proposals.length, "Index out of bounds");
        
        Proposal storage proposal = proposals[_proposalId];

        if (hasVoted[_proposalId][msg.sender]) {
            if (receipts[_proposalId][msg.sender] != _supports) {
                if (_supports) {
                    proposal.noCount--;
                    proposal.yesCount++;
                } else {
                    proposal.yesCount--;
                    proposal.noCount++;
                }
                receipts[_proposalId][msg.sender] = _supports;
            }
        } else {
            if (_supports) {
                proposal.yesCount++;
            } else {
                proposal.noCount++;
            }
            hasVoted[_proposalId][msg.sender] = true;
            receipts[_proposalId][msg.sender] = _supports;
        }

        emit VoteCast(_proposalId, msg.sender);

        
        if (proposal.yesCount >= 10 && !proposal.executed) {
            proposal.executed = true;
            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Execution failed");
        }
    }
}
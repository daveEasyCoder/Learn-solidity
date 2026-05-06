// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 1: Proposal
contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal(_target, _data, 0, 0));
    }
}

// 2: Cast a Vote
contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal(_target, _data, 0, 0));
    }

    function castVote(uint proposalId, bool support) external {
        if (support) {
            proposals[proposalId].yesCount++;
        } else {
            proposals[proposalId].noCount++;
        }
    }
}

// 3: Multiple Votes
contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    enum VoteStates { Absent, Yes, No }

    Proposal[] public proposals;
    mapping(uint => mapping(address => VoteStates)) public votes;

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal(_target, _data, 0, 0));
    }

    function castVote(uint proposalId, bool support) external {
        Proposal storage proposal = proposals[proposalId];
        VoteStates state = votes[proposalId][msg.sender];

        if (state == VoteStates.Yes) {
            proposal.yesCount--;
        }
        if (state == VoteStates.No) {
            proposal.noCount--;
        }

        if (support) {
            proposal.yesCount++;
            votes[proposalId][msg.sender] = VoteStates.Yes;
        } else {
            proposal.noCount++;
            votes[proposalId][msg.sender] = VoteStates.No;
        }
    }
}

// 4: Voting Events
contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    enum VoteStates { Absent, Yes, No }

    event ProposalCreated(uint);
    event VoteCast(uint, address indexed);

    Proposal[] public proposals;
    mapping(uint => mapping(address => VoteStates)) public votes;

    function newProposal(address _target, bytes calldata _data) external {
        proposals.push(Proposal(_target, _data, 0, 0));
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external {
        Proposal storage proposal = proposals[proposalId];
        VoteStates state = votes[proposalId][msg.sender];

        if (state == VoteStates.Yes) {
            proposal.yesCount--;
        }
        if (state == VoteStates.No) {
            proposal.noCount--;
        }

        if (support) {
            proposal.yesCount++;
            votes[proposalId][msg.sender] = VoteStates.Yes;
        } else {
            proposal.noCount++;
            votes[proposalId][msg.sender] = VoteStates.No;
        }

        emit VoteCast(proposalId, msg.sender);
    }
}

// 5: Members
contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    enum VoteStates { Absent, Yes, No }

    event ProposalCreated(uint);
    event VoteCast(uint, address indexed);

    Proposal[] public proposals;
    mapping(uint => mapping(address => VoteStates)) public votes;
    mapping(address => bool) public members;

    constructor(address[] memory _members) {
        members[msg.sender] = true;
        for (uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
    }

    modifier onlyMembers() {
        require(members[msg.sender]);
        _;
    }

    function newProposal(address _target, bytes calldata _data) external onlyMembers {
        proposals.push(Proposal(_target, _data, 0, 0));
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external onlyMembers {
        Proposal storage proposal = proposals[proposalId];
        VoteStates state = votes[proposalId][msg.sender];

        if (state == VoteStates.Yes) {
            proposal.yesCount--;
        }
        if (state == VoteStates.No) {
            proposal.noCount--;
        }

        if (support) {
            proposal.yesCount++;
            votes[proposalId][msg.sender] = VoteStates.Yes;
        } else {
            proposal.noCount++;
            votes[proposalId][msg.sender] = VoteStates.No;
        }

        emit VoteCast(proposalId, msg.sender);
    }
}

// 6: Execute
contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed;
    }

    enum VoteStates { Absent, Yes, No }

    event ProposalCreated(uint);
    event VoteCast(uint, address indexed);

    Proposal[] public proposals;
    mapping(uint => mapping(address => VoteStates)) public votes;
    mapping(address => bool) public members;

    constructor(address[] memory _members) {
        members[msg.sender] = true;
        for (uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
    }

    modifier onlyMembers() {
        require(members[msg.sender]);
        _;
    }

    function newProposal(address _target, bytes calldata _data) external onlyMembers {
        proposals.push(Proposal(_target, _data, 0, 0, false));
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external onlyMembers {
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed);

        VoteStates state = votes[proposalId][msg.sender];

        if (state == VoteStates.Yes) {
            proposal.yesCount--;
        }
        if (state == VoteStates.No) {
            proposal.noCount--;
        }

        if (support) {
            proposal.yesCount++;
            votes[proposalId][msg.sender] = VoteStates.Yes;
        } else {
            proposal.noCount++;
            votes[proposalId][msg.sender] = VoteStates.No;
        }

        if (proposal.yesCount == 10) {
            proposal.executed = true;
            (bool success, ) = proposal.target.call(proposal.data);
            require(success);
        }

        emit VoteCast(proposalId, msg.sender);
    }
}

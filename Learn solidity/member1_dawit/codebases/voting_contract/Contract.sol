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

    function newProposal(address target, bytes calldata data) external {
        proposals.push(Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0
        }));
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

    function newProposal(address _target, bytes memory _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));
    }

    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposalId");

        Proposal storage proposal = proposals[proposalId];

        if (support) {
            proposal.yesCount += 1;
        } else {
            proposal.noCount += 1;
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

    Proposal[] public proposals;

    mapping(address => mapping(uint => bool)) public hasVoted;

    mapping(address => mapping(uint => bool)) public voteChoice;

    function newProposal(address _target, bytes memory _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));
    }

    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposalId");

        Proposal storage proposal = proposals[proposalId];


        if (hasVoted[msg.sender][proposalId]) {
            bool previousVote = voteChoice[msg.sender][proposalId];

            if (previousVote) {
                proposal.yesCount -= 1;
            } else {
                proposal.noCount -= 1;
            }
        }

        
        if (support) {
            proposal.yesCount += 1;
        } else {
            proposal.noCount += 1;
        }

        hasVoted[msg.sender][proposalId] = true;
        voteChoice[msg.sender][proposalId] = support;
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

    Proposal[] public proposals;

    mapping(address => mapping(uint => bool)) public hasVoted;
    mapping(address => mapping(uint => bool)) public voteChoice;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    function newProposal(address _target, bytes memory _data) external {
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));

    
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external {
        require(proposalId < proposals.length, "Invalid proposalId");

        Proposal storage proposal = proposals[proposalId];

        if (hasVoted[msg.sender][proposalId]) {
            bool previousVote = voteChoice[msg.sender][proposalId];

            if (previousVote) {
                proposal.yesCount -= 1;
            } else {
                proposal.noCount -= 1;
            }
        }

        if (support) {
            proposal.yesCount += 1;
        } else {
            proposal.noCount += 1;
        }

        hasVoted[msg.sender][proposalId] = true;
        voteChoice[msg.sender][proposalId] = support;

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

    Proposal[] public proposals;

    mapping(address => mapping(uint => bool)) public hasVoted;
    mapping(address => mapping(uint => bool)) public voteChoice;

    // MEMBERSHIP
    mapping(address => bool) public isMember;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    // CONSTRUCTOR (MEMBERS SETUP)
    constructor(address[] memory _members) {
        isMember[msg.sender] = true; // deployer is always a member

        for (uint i = 0; i < _members.length; i++) {
            isMember[_members[i]] = true;
        }
    }

    function newProposal(address _target, bytes memory _data) external {
        require(isMember[msg.sender], "Not a member");

        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external {
        require(isMember[msg.sender], "Not a member");
        require(proposalId < proposals.length, "Invalid proposalId");

        Proposal storage proposal = proposals[proposalId];

        if (hasVoted[msg.sender][proposalId]) {
            bool previousVote = voteChoice[msg.sender][proposalId];

            if (previousVote) {
                proposal.yesCount -= 1;
            } else {
                proposal.noCount -= 1;
            }
        }

        if (support) {
            proposal.yesCount += 1;
        } else {
            proposal.noCount += 1;
        }

        hasVoted[msg.sender][proposalId] = true;
        voteChoice[msg.sender][proposalId] = support;

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
    }

    Proposal[] public proposals;

    mapping(address => mapping(uint => bool)) public hasVoted;
    mapping(address => mapping(uint => bool)) public voteChoice;

    mapping(address => bool) public isMember;

    mapping(uint => bool) public executed;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    constructor(address[] memory _members) {
        isMember[msg.sender] = true;

        for (uint i = 0; i < _members.length; i++) {
            isMember[_members[i]] = true;
        }
    }

    function newProposal(address _target, bytes memory _data) external {
        require(isMember[msg.sender], "Not a member");

        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0
        }));

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool support) external {
        require(isMember[msg.sender], "Not a member");
        require(proposalId < proposals.length, "Invalid proposalId");

        Proposal storage proposal = proposals[proposalId];

        // handle vote change
        if (hasVoted[msg.sender][proposalId]) {
            bool previousVote = voteChoice[msg.sender][proposalId];

            if (previousVote) {
                proposal.yesCount -= 1;
            } else {
                proposal.noCount -= 1;
            }
        }

        // apply new vote
        if (support) {
            proposal.yesCount += 1;
        } else {
            proposal.noCount += 1;
        }

        hasVoted[msg.sender][proposalId] = true;
        voteChoice[msg.sender][proposalId] = support;

        emit VoteCast(proposalId, msg.sender);

        if (
            proposal.yesCount >= 10 &&
            !executed[proposalId]
        ) {
            executed[proposalId] = true;

            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Execution failed");
        }
    }
}
// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// 1: Vote Storage
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote public vote;

    function createVote(Choices choice) external {
        vote = Vote(choice, msg.sender);
    }
}

// 2: Vote Memory
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    function createVote(Choices choice) external view returns (Vote memory) {
        return Vote(choice, msg.sender);
    }
}

// 3: Vote Array
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external {
        votes.push(Vote(choice, msg.sender));
    }
}

// 4: Choice Lookup
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external {
        votes.push(Vote(choice, msg.sender));
    }

    function hasVoted(address voter) external view returns (bool) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return true;
            }
        }
        return false;
    }

    function findChoice(address voter) external view returns (Choices choice) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return votes[i].choice;
            }
        }
    }
}

// 5: Single Vote
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external {
        require(!hasVoted(msg.sender));
        votes.push(Vote(choice, msg.sender));
    }

    function hasVoted(address voter) public view returns (bool) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return true;
            }
        }
        return false;
    }

    function findChoice(address voter) external view returns (Choices choice) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return votes[i].choice;
            }
        }
    }
}

// 6: Change Vote
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external {
        require(!hasVoted(msg.sender));
        votes.push(Vote(choice, msg.sender));
    }

    function changeVote(Choices choice) external {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == msg.sender) {
                votes[i].choice = choice;
                return;
            }
        }
        revert();
    }

    function hasVoted(address voter) public view returns (bool) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return true;
            }
        }
        return false;
    }

    function findChoice(address voter) external view returns (Choices choice) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return votes[i].choice;
            }
        }
    }
}

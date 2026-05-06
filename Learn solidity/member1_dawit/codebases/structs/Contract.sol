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
        vote = Vote({
            choice: choice,
            voter: msg.sender
        });
    }
}

// 2: Vote Memory
contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    function createVote(Choices choice)
        external
        view
        returns (Vote memory)
    {
        return Vote({
            choice: choice,
            voter: msg.sender
        });
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
        votes.push(Vote({
            choice: choice,
            voter: msg.sender
        }));
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
        votes.push(Vote({
            choice: choice,
            voter: msg.sender
        }));
    }

    // shared internal helper
    function _findVote(address voter) internal view returns (int256) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return int256(i);
            }
        }
        return -1;
    }

    function hasVoted(address user) external view returns (bool) {
        return _findVote(user) != -1;
    }

    function findChoice(address user) external view returns (Choices) {
        int256 index = _findVote(user);
        return votes[uint256(index)].choice;
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
        require(!_hasVoted(msg.sender), "Already voted");

        votes.push(Vote({
            choice: choice,
            voter: msg.sender
        }));
    }

    function _findVote(address voter) internal view returns (int256) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return int256(i);
            }
        }
        return -1;
    }

    function _hasVoted(address user) internal view returns (bool) {
        return _findVote(user) != -1;
    }

    function hasVoted(address user) external view returns (bool) {
        return _hasVoted(user);
    }

    function findChoice(address user) external view returns (Choices) {
        int256 index = _findVote(user);
        return votes[uint256(index)].choice;
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
        require(!_hasVoted(msg.sender), "Already voted");

        votes.push(Vote({
            choice: choice,
            voter: msg.sender
        }));
    }

    function _findVote(address voter) internal view returns (int256) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return int256(i);
            }
        }
        return -1;
    }

    function _hasVoted(address user) internal view returns (bool) {
        return _findVote(user) != -1;
    }

    function hasVoted(address user) external view returns (bool) {
        return _hasVoted(user);
    }

    function findChoice(address user) external view returns (Choices) {
        int256 index = _findVote(user);
        return votes[uint256(index)].choice;
    }
    function changeVote(Choices choice) external {
    int256 index = _findVote(msg.sender);

    require(index != -1, "No existing vote");

    votes[uint256(index)].choice = choice;
}
}
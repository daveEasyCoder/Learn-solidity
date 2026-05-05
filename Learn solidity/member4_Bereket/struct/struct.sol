1: Vote Storage

// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    enum Choices { Yes, No }

    // 1. Create the Vote struct
    struct Vote {
        Choices choice;
        address voter;
    }

    // 2. Create a public storage variable of the Vote type
    Vote public vote;

    function createVote(Choices choice) external {
        // 3. Create a new instance and store it in the 'vote' variable
        // We use msg.sender to automatically capture the address calling the function
        vote = Vote(choice, msg.sender);
    }
}



2: Vote Memory


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    // Goal: Return a Vote struct from an external view function
    function createVote(Choices choice) external view returns (Vote memory) {
        // We initialize and return the struct in memory
        // This uses the choice argument and the msg.sender
        return Vote(choice, msg.sender);
    }
}


3: Vote Array


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    // 1. Create the public storage array
    Vote[] public votes;

    function createVote(Choices choice) external {
        // 2. Push a new Vote instance onto the 'votes' array
        votes.push(Vote(choice, msg.sender));
    }
}



4: Choice Lookup



// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

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

    // Goal 1: Check if an address has cast a vote
    function hasVoted(address voter) external view returns (bool) {
        for(uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return true;
            }
        }
        return false;
    }

    // Goal 2: Find the choice for a specific address
    function findChoice(address voter) external view returns (Choices) {
        for(uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return votes[i].choice;
            }
        }
        // Returning a default value or reverting; prompt says no need to worry about "not found"
        return Choices.Yes; 
    }
}


5: Single Vote



// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external {
        // Check if the user has already voted
        require(!hasVoted(msg.sender), "Address has already cast a vote.");

        votes.push(Vote(choice, msg.sender));
    }

    // Changed from external to public so createVote can call it
    function hasVoted(address voter) public view returns (bool) {
        for(uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return true;
            }
        }
        return false;
    }

    function findChoice(address voter) external view returns (Choices) {
        for(uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return votes[i].choice;
            }
        }
        return Choices.Yes; 
    }
}


6: Change Vote


// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external {
        require(!hasVoted(msg.sender), "Already voted");
        votes.push(Vote(choice, msg.sender));
    }

    function changeVote(Choices choice) external {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == msg.sender) {
                // Use storage to point to the actual array element
                Vote storage userVote = votes[i];
                userVote.choice = choice;
                return;
            }
        }
        revert("No existing vote found to change.");
    }

    // Must be public so createVote can access it internally
    function hasVoted(address voter) public view returns (bool) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return true;
            }
        }
        return false;
    }

    // This is the function the compiler was missing
    function findChoice(address voter) public view returns (Choices) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == voter) {
                return votes[i].choice;
            }
        }
        revert("Voter not found.");
    }
}




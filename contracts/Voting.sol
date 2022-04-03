pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Voting {
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    struct Election {
        uint256 registrationEnd;
    }

    struct Voting {
        uint256 votingEnd;
    }

    mapping(uint => Candidate) public candidates;

    mapping(uint => Election) public elections;

    // Store accounts that have voted
    mapping(address => bool) public voters;

    uint256 public candidatesCount;

    uint256 registerDuration = 5;

    uint256 voteDuration = 5;

    uint256 lastRun;

    event votedEvent (
        uint indexed _candidateId
    );

    event registerEvent (
        uint indexed _candidateId
    );

    function register(string memory _name) public {
        uint now = block.timestamp;

        Election memory election = Election(now + (registerDuration * 1 seconds));

        console.log(election.registrationEnd);

        require(now < election.registrationEnd, "Registration period has already ended!");

        candidatesCount++;

        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    
    function vote(uint _candidateId) public {
        console.log(msg.sender);

        voters[msg.sender] = true;

        require(!voters[msg.sender], "This address has already voted!");

        require(_candidateId > 0 && _candidateId <= candidatesCount);

        Voting memory voting = Voting(block.timestamp + (voteDuration * 1 seconds));

        require(block.timestamp < voting.votingEnd, "Voting period has already ended!");

        candidates[_candidateId].voteCount++;

        emit votedEvent(_candidateId);
    }

    function getCandidate(uint id) public view returns (string memory) {
        return candidates[id].name;
    }

    function getCandidateVotes(uint id) public view returns (uint256) {
        return candidates[id].voteCount;
    }
}

pragma solidity >=0.4.21 <0.7.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    //store accounts that have voted
    mapping(address=> bool) public voters;

    // Read/write candidates
    mapping(uint => Candidate) public candidates;

    // Store Candidates Count
    uint public candidatesCount;
    
    //runs once when the app is deployed 
    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
        addCandidate("Candidate 3");
    }

    //function that add a new candidate 
    //called in constructor
    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
    function vote (uint _candidateId) public {
        //conditions to check for before recording a vote
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate 
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update vote Count of the candidateId
        candidates[_candidateId].voteCount ++;
    }

}
pragma solidity >=0.4.22 <0.6.0;

contract Ballot {
    
    struct Voter {
        uint weight; //weight accumulated by delegation
        bool voted; //if true, already voted
        address delegate; //person delegated to
        uint vote; //index of vote choice
    }

    struct Proposal {
        bytes32 name; //short name
        uint voteCount; //number of votes
    }

    address public chairperson;

    //make voters variable that stores a Voter for each address
    mapping(address => Voter) public voters;

    Proposal[] public proposals; //dynamic array of proposals

    //create new Ballot
    constructor(bytes32[] memory proposalNames) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        //for each name given in the ballot, make an object for it
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }
}
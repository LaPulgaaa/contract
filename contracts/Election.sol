// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;


contract Election {

    struct Voter{
    address votaddr;
    bool voted;
    address votedto;
    }

    struct Candidate {
        address candadr;
        string name;
        uint128 votes;
    }

    address[] registry;

    uint128 voterCount;
    mapping (address => Voter) regdVoter;

    uint128 candCount;
    mapping (address => Candidate) regdCand;

    uint startTime;
    uint endTime;

    constructor(uint _startTime, uint _endTime){
        voterCount = 0;
        candCount = 0;
        startTime = _startTime;
        endTime = _endTime;
    }

    function registerVoter(address voterAddr) public returns(bool){
        regdVoter[voterAddr] = Voter({votaddr: voterAddr, voted: false, votedto: address(0x00)});
        voterCount++;
        return true;
    }

    function registerCandidate(address candAddr, string calldata name) public returns(bool){
        regdCand[candAddr] = Candidate({candadr: candAddr, name: name, votes: 0});
        candCount++;
        return true;
    }

    function vote(address voterAddr, address candAddr) public returns(bool){

        require(block.timestamp >= startTime, "Voting has not started yet!!");
        require(block.timestamp <= endTime, "Voting has ended!");

        // since we want the reference of the particular voter's struct
        Voter storage v = regdVoter[voterAddr];

        require(v.votaddr != address(0x0000000000000000000000000000000000000000));
        require(v.voted == false, "Address has already casted a vote");

        Candidate storage c = regdCand[candAddr];
        require(c.candadr != address(0x0000000000000000000000000000000000000000));

        c.votes+=1;
        v.votedto = candAddr;
        v.voted = true;

        registry.push(candAddr);

        return true;
    }

    function getVoterCount() public view returns(uint128){
        return voterCount;
    }

    function getCandidateCount() public view returns(uint128){
        return candCount;
    }

    function getResult() public view returns(address, uint128){
        // since we want to create a temp copy
        address[] memory voterBox = registry;

        require(block.timestamp > endTime, "Voting is in progress. Results to be announced after it ends.");
        require(voterBox.length > 0, "No votes were casted.");

        // Boyer-moore's voting algorithm
        address leader = voterBox[0];
        uint count = 1;

        for(uint i=1; i<voterBox.length; i++){
            if(voterBox[i] == leader){
                count = count+1;
            }
            else{
                count = count-1;

                if(count<0){
                    leader = voterBox[i];
                    count = 1;
                }
            }
        }

        return (leader, regdCand[leader].votes);

    }
}
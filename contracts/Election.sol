// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

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

contract Election {

    uint128 voterCount;
    mapping (address => Voter) regdVoter;

    uint128 candCount;
    mapping (address => Candidate) regdCand;

    constructor(){
        voterCount = 0;
        candCount = 0;
    }

    function registerVoter(address voterAddr) public returns(bool){
        regdVoter[voterAddr] = Voter({votaddr: voterAddr, voted: false, votedto: address(0x00)});
        voterCount++;
        return true;
    }

    function registerCandidate(address candAddr, string calldata name) public returns(bool){
        regdCand[candAddr] = Candidate({candadr: candAddr, name: name, votes: 0});
        return true;
    }

    function vote(address voterAddr, address candAddr) public returns(bool){
        Voter storage v = regdVoter[voterAddr];

        require(v.votaddr != address(0x0000000000000000000000000000000000000000));
        require(v.voted == false, "Address has already casted a vote");

        Candidate storage c = regdCand[candAddr];
        require(c.candadr != address(0x0000000000000000000000000000000000000000));

        c.votes+=1;
        v.votedto = candAddr;

        return true;
    }
}
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

struct Candidate {
    address addr;
    string  name;
    uint128 vote;
}


contract Vote {

    uint128 public voter_count;
    mapping (uint128 => address) public voter_list;
    uint128 public candidate_count;
    mapping (uint128 => Candidate) public candidate_list;


    constructor(){
        candidate_count = 0;
        voter_count = 0;
    }

    function register_voter(address voter) public returns(bool){
        voter_list[voter_count++] = voter;
        return true;
    }

    function get_voter_count() public view returns(uint128){
        return voter_count;
    }

    function register_candidate(address addr, string memory name) public returns(uint128){
        candidate_list[candidate_count++] = Candidate(addr, name, 0);

        return candidate_count;
    }

    function get_candidate_count() public view returns(uint128){
        return candidate_count;
    }

    function vote(uint128 cand_id) public returns(string memory){
        Candidate storage cand = candidate_list[cand_id-1]; // for 1st candidate the index is 0
        cand.vote += 1;
        string memory name = cand.name;
        return name;
    }
}
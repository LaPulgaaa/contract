// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

contract Vote{
    uint public x;
    uint public y;

    constructor(){
        x = 0;
        y = 0;
    }

    function voteFirst() public{
        x+=1;
    }

    function voteSecond() public {
        y+=1;
    }

    function getVoteFirst() public view returns(uint){
        return x;
    }

    function getVoteSecond() public view returns(uint){
        return y;
    }
}
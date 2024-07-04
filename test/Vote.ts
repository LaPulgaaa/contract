import hre from "hardhat";
import {expect} from "chai";

describe("testing Vote smart contract ",()=>{
    async function deployContract(){

        const [owner, otherAccounts ] = await hre.ethers.getSigners();

        const Vote = await hre.ethers.getContractFactory("Vote");
        const vote = await Vote.deploy();

        return {vote, owner, other: otherAccounts};
    }

    it("it should correctly deploy smart contract",async()=>{
        const {vote, owner, other} = await deployContract();

        await vote.voteFirst();
        await vote.voteSecond();

        await vote.voteFirst();

        const vote_a = await vote.getVoteFirst();

        expect(vote_a).to.be.equal(2);

        const vote_b = await vote.getVoteSecond();

        expect(vote_b).to.be.equal(1);
    })
})
import { config } from "dotenv"
import hre from "hardhat"
import {AlchemyProvider, Network, Wallet, ContractFactory} from 'ethers';

config();

async function main(){

    const artifacts = await hre.artifacts.readArtifact("Vote");

    const network = new Network("sepolia",11155111);

    const provider = new AlchemyProvider(network,process.env.API_KEY);

    const wallet = new Wallet(process.env.PRIVATE_KEY!, provider);

    let factory = new ContractFactory(artifacts.abi, artifacts.bytecode, wallet);

    let vote = await factory.deploy();

    console.log(await vote.getAddress())

    await vote.waitForDeployment();
}


main().then(()=>{
    process.exit(0)
}).catch(error=>{
    console.log(error);
    process.exit(1);
})
import { Wallet, AlchemyProvider, Network ,Contract } from "ethers";
import hre from "hardhat";

const ContractAddress = "0xeF454dC8179572E5823bc147489a8257E8b91388";

async function main(){

    const artifact = await hre.artifacts.readArtifact("Vote");

    const network = new Network("sepolia",11155111);
    const provider = new AlchemyProvider(network, process.env.API_KEY!);
    const wallet = new Wallet(process.env.PRIVATE_KEY!,provider);

    const contract = new Contract(ContractAddress, artifact.abi, wallet);

    const first = Number.parseInt(await contract.getVoteFirst());
    const second = Number.parseInt(await contract.getVoteSecond());

    if(first>second){
        console.log("First won!!!");
    }
    else if(second>first){
        console.log("Second won!!!")
    }
    else
        console.log("it is tied")

}

main().then(()=>{
    process.exit(0);
}).catch((err)=>{
    console.log(err);
    process.exit(1);
})
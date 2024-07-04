import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import { config } from "dotenv";


config();

const hardhat_config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks:{
    sepolia:{
      url: process.env.SEPOLIA_URL,
      accounts: [process.env.PRIVATE_KEY!]
    }
  }
};

export default hardhat_config;

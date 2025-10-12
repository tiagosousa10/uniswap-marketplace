const { chainId } = require("wagmi");

require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */

const NETWORK_RPC_URL =
  "https://rpc.ankr.com/eth_holesky/ec94445152204157c240ed5d4b76c35c8c5fd750ac76d6d594d7451d05ce7b60";
const PRIVATE_KEY =
  "a7b28ae46f500d3a383ef5823ed5e62aa9ea4956381c6a5e5da2cffd74bb6242";
module.exports = {
  solidity: "0.8.0",
  networks: {
    hardhat: {},
    holesky: {
      url: NETWORK_RPC_URL,
      accounts: [`0x${PRIVATE_KEY}`],
      chainId: 17000,
    },
  },
};

/* 
networks: {
    hardhat: {
      chainId: 1337,
    },
    holesky: {
      url: process.env.NETWORK_RPC_URL || process.env.NETWORK_RPC_URL,
      accounts:
        process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
      chainId: 17000,
    },
  },


*/

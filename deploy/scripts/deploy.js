const hre = require("hardhat");

async function main() {
  const CustomEx = await hre.ethers.getContractFactory("CustomEx");
  const customDex = await CustomEx.deploy();

  await customDex.deployed();
  console.log("CustomEx deployed to:", customDex.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

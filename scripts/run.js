const { Contract } = require("ethers");
const hre = require("hardhat");

async function main() {
  const Wish = await hre.ethers.getContractFactory("Wish");
  const wish = await Wish.deploy();
  console.log("contarct deployed at address:", wish.address);

  await wish.deployed();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

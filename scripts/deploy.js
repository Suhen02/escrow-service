

const hre = require("hardhat");

async function main() {
  const [buyer, seller] = await hre.ethers.getSigners();

  const Escrow = await hre.ethers.getContractFactory("Escrow");

  const escrow = await Escrow.deploy(seller.address);

  await escrow.deployed();

  console.log("Escrow deployed to:", escrow.address);
  console.log("Buyer:", buyer.address);
  console.log("Seller:", seller.address);
}

main();
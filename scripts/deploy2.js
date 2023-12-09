// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const ecolot = await hre.ethers.deployContract("ECO4RewardLotteryDaily", [
    "0x0638169f3b57905858e6d9aB1f83741880ddDd57",
    838,
    "0x354d2f95da55398f44b7cff77da56283d9c6c829a4bdf1bbcaf2ad6a4d081f61",
    2500000,
    "0x2eD832Ba664535e5886b75D64C46EB9a228C2610",
  ]);

  await ecolot.waitForDeployment();

  console.log(`Contract deployed to ${ecolot.target}`);

  console.log("Sleeping.....");
  // Wait for etherscan to notice that the contract has been deployed
  await sleep(30000);

  // Verify the contract after deploying
  await hre.run("verify:verify", {
    address: ecolot.target,
    constructorArguments: [
      "0x0638169f3b57905858e6d9aB1f83741880ddDd57",
      838,
      "0x354d2f95da55398f44b7cff77da56283d9c6c829a4bdf1bbcaf2ad6a4d081f61",
      2500000,
      "0x2eD832Ba664535e5886b75D64C46EB9a228C2610",
    ],
    contract: "contracts/Lottery.sol:ECO4RewardLotteryDaily",
  });

  function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

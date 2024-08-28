// This script demonstrates the use of the Hardhat Runtime Environment (HRE).
// It allows us to run the script standalone using `node <script>`.
// Alternatively, you can run the script with `npx hardhat run <script>`,
// which compiles the contracts, adds the Hardhat Runtime Environment's
// members to the global scope, and executes the script.

const hre = require("hardhat");

async function main() {
  // Initial balance to be set in the deployed contract
  const initBalance = 1;

  // Retrieve the contract factory for our "Assessment" contract
  const Assessment = await hre.ethers.getContractFactory("Assessment");

  // Deploy the contract with the initial balance
  const assessment = await Assessment.deploy(initBalance);

  // Wait for the deployment to be mined
  await assessment.deployed();

  // Log the address where the contract has been deployed
  console.log(`A contract with balance of ${initBalance} ETH deployed to ${assessment.address}`);
}

// Use a pattern that allows for async/await usage and proper error handling
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

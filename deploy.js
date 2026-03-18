const hre = require("hardhat");

async function main() {
  // Mainnet Uniswap V3 Position Manager Address
  const POSITION_MANAGER = "0xC36442b4a4522E871399CD717aBDD847Ab11FE88";

  const LiquidityManager = await hre.ethers.getContractFactory("LiquidityManager");
  const manager = await LiquidityManager.deploy(POSITION_MANAGER);

  await manager.waitForDeployment();
  console.log(`LiquidityManager deployed to: ${await manager.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

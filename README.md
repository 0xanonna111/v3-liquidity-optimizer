# Uniswap V3 Liquidity Optimizer

This repository contains a specialized smart contract designed to interact with the **Uniswap V3 NonfungiblePositionManager**. It simplifies the complex process of providing concentrated liquidity by handling tick calculations and token approvals in a single entry point.

## Key Features
* **Concentrated Liquidity:** Supply capital within specific price "ticks" to earn higher fees than V2-style pools.
* **Automated Tick Rounding:** Ensures your price ranges align with the pool's `tickSpacing`.
* **Position Tracking:** Returns the NFT `tokenId` representing your unique LP position.

## Technical Overview
Uniswap V3 represents LP positions as NFTs (ERC-721). This contract acts as a proxy to:
1.  **Mint:** Create a new position with a specified range and liquidity.
2.  **Increase:** Add more tokens to an existing NFT position.
3.  **Collect:** Harvest earned trading fees without closing the position.

## Requirements
* Access to a Uniswap V3 Factory and Position Manager address (e.g., Ethereum, Polygon, Base).
* WETH or other ERC-20 pairs for testing.

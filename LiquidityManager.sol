// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";

contract LiquidityManager {
    INonfungiblePositionManager public immutable positionManager;

    constructor(address _positionManager) {
        positionManager = INonfungiblePositionManager(_positionManager);
    }

    function mintNewPosition(
        address token0,
        address token1,
        uint24 fee,
        int24 tickLower,
        int24 tickUpper,
        uint256 amount0Desired,
        uint256 amount1Desired
    ) external returns (uint256 tokenId, uint128 liquidity, uint256 amount0, uint256 amount1) {
        
        TransferHelper.safeTransferFrom(token0, msg.sender, address(this), amount0Desired);
        TransferHelper.safeTransferFrom(token1, msg.sender, address(this), amount1Desired);

        TransferHelper.safeApprove(token0, address(positionManager), amount0Desired);
        TransferHelper.safeApprove(token1, address(positionManager), amount1Desired);

        INonfungiblePositionManager.MintParams memory params =
            INonfungiblePositionManager.MintParams({
                token0: token0,
                token1: token1,
                fee: fee,
                tickLower: tickLower,
                tickUpper: tickUpper,
                amount0Desired: amount0Desired,
                amount1Desired: amount1Desired,
                amount0Min: 0,
                amount1Min: 0,
                recipient: msg.sender,
                deadline: block.timestamp
            });

        (tokenId, liquidity, amount0, amount1) = positionManager.mint(params);

        // Refund dust
        if (amount0 < amount0Desired) {
            TransferHelper.safeApprove(token0, address(positionManager), 0);
            TransferHelper.safeTransfer(token0, msg.sender, amount0Desired - amount0);
        }
        if (amount1 < amount1Desired) {
            TransferHelper.safeApprove(token1, address(positionManager), 0);
            TransferHelper.safeTransfer(token1, msg.sender, amount1Desired - amount1);
        }
    }
}

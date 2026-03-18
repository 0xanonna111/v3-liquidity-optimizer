/**
 * Helper to round a price tick to the nearest valid tick spacing.
 * Uniswap V3 requires ticks to be multiples of the pool's spacing (e.g., 60 for 0.3% pools).
 */
function getNearestTick(tick, spacing) {
  return Math.round(tick / spacing) * spacing;
}

module.exports = { getNearestTick };

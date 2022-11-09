// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import '../libraries/Path.sol';

contract PathTest {
    function hasMultiplePools(bytes memory path) public pure returns (bool) {
        return Path.hasMultiplePools(path);
    }

    function decodeFirstPool(bytes memory path)
        public
        pure
        returns (
            address tokenA,
            address tokenB,
            uint24 fee
        )
    {
        return Path.decodeFirstPool(path);
    }

    function getFirstPool(bytes memory path) public pure returns (bytes memory) {
        return Path.getFirstPool(path);
    }

    function skipToken(bytes memory path) public pure returns (bytes memory) {
        return Path.skipToken(path);
    }
}

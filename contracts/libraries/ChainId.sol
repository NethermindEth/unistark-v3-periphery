// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.14;

/// @title Function for getting the current chain ID
library ChainId {
    /// @dev Gets the current chain ID
    /// @return chainId The current chain ID
    function get() internal pure returns (uint256 chainId) {
        // Chain id is used to defend from simple replay attacks
        // on EVM compatible nets. Since cairo is not one, this can
        // be anything
        chainId = 0;
    }
}

// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.14;

import '../../openzeppelin/contracts/token/ERC20/IERC20.sol';
import '../../openzeppelin/contracts/token/ERC20/ERC20.sol';

/// @title Interface for WETH9
interface IWETH9 is IERC20 {
    /// @notice Deposit ether to get wrapped ether
    function deposit() external payable;

    /// @notice Withdraw wrapped ether to get ether
    function withdraw(uint256) external;
}

contract WETH9 is ERC20 {
    constructor() ERC20('Dummy', 'DMY') {}

    function deposit() external payable {}

    function withdraw(uint256) external {}
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import '../base64-sol/base64.sol';

contract Base64Test {
    function encode(bytes memory data) external pure returns (string memory) {
        return Base64.encode(data);
    }
}

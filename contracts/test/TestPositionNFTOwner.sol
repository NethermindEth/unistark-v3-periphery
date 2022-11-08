// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import '../interfaces/external/IERC1271.sol';

contract TestPositionNFTOwner is IERC1271 {
    address public owner;

    function setOwner(address _owner) external {
        owner = _owner;
    }

    function isValidSignature(bytes32 hash, bytes memory signature) external view override returns (bytes4 magicValue) {
        bytes memory tempR = new bytes(32);
        bytes memory tempS = new bytes(32);
        for (uint index = 0; index < 32; index++) {
            tempR[index] = signature[32 + index];
            tempS[index] = signature[64 + index];
        }

        bytes32 r = bytes32(tempR);
        bytes32 s = bytes32(tempS);
        uint8 v = uint8(signature[96]);

        if (address(uint256(ecrecover(hash, v, r, s))) == owner) {
            return bytes4(0x1626ba7e);
        } else {
            return bytes4(0);
        }
    }
}

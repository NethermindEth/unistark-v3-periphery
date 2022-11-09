// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;
pragma abicoder v2;

import '../libraries/NFTDescriptor.sol';
import '../libraries/NFTSVG.sol';
import '../libraries/HexStrings.sol';

contract NFTDescriptorTest {
    using HexStrings for uint256;

    function constructTokenURI(
        uint256 tokenId,
        address quoteTokenAddress,
        address baseTokenAddress,
        string calldata quoteTokenSymbol,
        string calldata baseTokenSymbol,
        uint8 quoteTokenDecimals,
        uint8 baseTokenDecimals,
        bool flipRatio,
        int24 tickLower,
        int24 tickUpper,
        int24 tickCurrent,
        int24 tickSpacing,
        uint24 fee,
        address poolAddress)
        public
        pure
        returns (string memory)
    {
        return NFTDescriptor.constructTokenURI(
            tokenId,
            quoteTokenAddress,
            baseTokenAddress,
            quoteTokenSymbol,
            baseTokenSymbol,
            quoteTokenDecimals,
            baseTokenDecimals,
            flipRatio,
            tickLower,
            tickUpper,
            tickCurrent,
            tickSpacing,
            fee,
            poolAddress);
    }

    function tickToDecimalString(
        int24 tick,
        int24 tickSpacing,
        uint8 token0Decimals,
        uint8 token1Decimals,
        bool flipRatio
    ) public pure returns (string memory) {
        return NFTDescriptor.tickToDecimalString(tick, tickSpacing, token0Decimals, token1Decimals, flipRatio);
    }

    function fixedPointToDecimalString(
        uint160 sqrtRatioX96,
        uint8 token0Decimals,
        uint8 token1Decimals
    ) public pure returns (string memory) {
        return NFTDescriptor.fixedPointToDecimalString(sqrtRatioX96, token0Decimals, token1Decimals);
    }

    function feeToPercentString(uint24 fee) public pure returns (string memory) {
        return NFTDescriptor.feeToPercentString(fee);
    }

    function addressToString(address _address) public pure returns (string memory) {
        return NFTDescriptor.addressToString(_address);
    }

    function generateSVGImage(
        uint256 tokenId,
        address quoteTokenAddress,
        address baseTokenAddress,
        string calldata quoteTokenSymbol,
        string calldata baseTokenSymbol,
        uint8 quoteTokenDecimals,
        uint8 baseTokenDecimals,
        bool flipRatio,
        int24 tickLower,
        int24 tickUpper,
        int24 tickCurrent,
        int24 tickSpacing,
        uint24 fee,
        address poolAddress
        ) public pure returns (string memory) {
        return NFTDescriptor.generateSVGImage(
            tokenId,
            quoteTokenAddress,
            baseTokenAddress,
            quoteTokenSymbol,
            baseTokenSymbol,
            quoteTokenDecimals,
            baseTokenDecimals,
            flipRatio,
            tickLower,
            tickUpper,
            tickCurrent,
            tickSpacing,
            fee,
            poolAddress);
    }

    function tokenToColorHex(address token, uint256 offset) public pure returns (string memory) {
        return NFTDescriptor.tokenToColorHex(uint256(token), offset);
    }

    function sliceTokenHex(address token, uint256 offset) public pure returns (uint256) {
        return NFTDescriptor.sliceTokenHex(uint256(token), offset);
    }

    function rangeLocation(int24 tickLower, int24 tickUpper) public pure returns (string memory, string memory) {
        return NFTSVG.rangeLocation(tickLower, tickUpper);
    }

    function isRare(uint256 tokenId, address poolAddress) public pure returns (bool) {
        return NFTSVG.isRare(tokenId, poolAddress);
    }
}

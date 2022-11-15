# General

## Libraries required:
- v3-core
- uniswap -> SafeERC20Namer
    - base64-sol
- openzeppelin

## Errors
### Solidity version
All pragma solidity versions were set to ^0.8.14. As result some changes were required:
- Casting between different size + different types variables. Solidity 0.8.14 requires that when casting between different data types that they have the same size (e.g. :heavy_check_mark: `address` to `uint160` or `int128` to `uint128` but not :x: `int8` to `uint16` ) 
    - `contracts/libraries/OracleLibrary.sol`
    - `contracts/libraries/PoolTicksCounter.sol`
    - `contracts/libraries/NFTDescriptor.sol`
    - `contracts/libraries/NFTSVG.sol`
    - `contracts/openzeppelin/contracts/utils/EnumerableMap.sol`
    - `contracts/openzeppelin/contracts/utils/EnumerableSet.sol`
- Warp uses a modified version of `solc 0.8.14`. `address` is 256 bits in size, so conversion to `uint160`  or vice versa are invalided now.  `ecrecover` function returns a `uint160` instead of an `address`. Files changed:
    - `contracts/libraries/PoolAddress.sol`
    - `contracts/openzeppelin/contracts/utils/EnumerableMap.sol`
    - `contracts/openzeppelin/contracts/utils/EnumerableSet.sol`
    - `contracts/openzeppelin/contracts/cryptography/ECDSA.sol`
    - `contracts/test/TestPositionNFTOwner.sol`
    - `contracts/base/ERC721Permit.sol`
    - `contracts/NonfungibleTokenPositionDescriptor.sol`
- No need to use operations sub, div, and mod from openzeppelin safeMath because since solidity 0.8 they are safe by default. Files:
    - `contracts/openzeppelin/contracts/math/SafeMath.sol`

### Solc errors
Warp uses JavaScript library `solc-typed-ast` to produce a Solidity AST. It appears it  has a bug when  dealing with double-quote strings inside single-quote strings('this should "be ok" but "its not"'), as well as with escape characters('\\n'). Files updated were:
- `contracts/libraries/NFTDescriptor.sol`
- `contracts/libraries/NFTSVG.sol`

### Currency
Cairo doesn't have it's own native currency written as part of the protocol (Ethereum has ETH) instead it uses Wrapped ETH token. Changes were needed to accommodate for this. Files updated:
- `contracts/base/PeripheryPayments.sol`
- `contracts/base/PeripheryPaymentsWithFee.sol`
- `contracts/base/PeripheryPayments.sol`
- `contracts/base/PeripheryPaymentsWithFee.sol`
- `contracts/libraries/TransferHelper.sol`
- `contracts/lib/contracts/libraries/SafeERC20Namer.sol` This also call an external token contract and parse the string returned, that logic isn't needed here.
- `contracts/openzeppelin/contracts/token/ERC20/ERC20.sol`

### Address

Cairo doesn't distinguish between address types so OpenZeppelin address isn't needed, neither any check about it. Files:
- `contracts/base/ERC721Permit.sol`
- `contracts/openzeppelin/contracts/token/ERC721/ERC721.sol`


## Unsupported features
To avoid unsupported features some changes were needed:
- Indexed parameters on events: These index keywords were just removed. Files:
    - `contracts/interfaces/INonfungiblePositionManager.sol`
    - `contracts/openzeppelin/contracts/token/ERC20/IERC20.sol`
    - `contracts/openzeppelin/contracts/token/ERC721/IERC721.sol`
- Yul Blocks: So far we don't support them so we write the logic with solidity or use cairo stubs instead. Files:
    - `contracts/libraries/BytesLib.sol`
    - `contracts/libraries/ChainId.sol`
    - `contracts/base64-sol/base64.sol`
    - `contracts/lens/Quoter.sol`
    - `contracts/openzeppelin/contracts/drafts/EIP712.sol`
    - `contracts/test/TestPositionNFTOwner.sol`
    - `contracts/openzeppelin/contracts/cryptography/ECDSA.sol`
- Nested Complex Types: Some functions recieve as argument a type that include arrays or other complex types, we use the properties of that type as arguments instead of having that type. Files:
    - `contracts/NonfungibleTokenPositionDescriptor.sol`
    - `contracts/libraries/NFTDescriptor.sol`
    - `contracts/test/NFTDescriptorTest.sol`
    - `contracts/interfaces/ISwapRouter.sol`
    - `contracts/SwapRouter.sol`
    - `contracts/NonfungiblePositionManager.sol` removed inheritance from Multicall
    - `contracts/base/Multicall.sol` This file was deleted. It's propose was to do multiple transactions at once but use nested complex types.
    - `contracts/interfaces/IMulticall.sol` deleted
    - `contracts/test/TestMulticall.sol` deleted
    - `contracts/lens/UniswapInterfaceMulticall.sol` deleted
- imports with @: The feature wasn't supported so path were updated to specify the directory where files are placed.
- gasleft: 
    - `contracts/test/Base64Test.sol`
    - `contracts/test/LiquidityAmountsTest.sol`
    - `contracts/test/NFTDescriptorTest.sol`
    - `contracts/test/NonfungiblePositionManagerPositionsGasTest.sol` deleted
    - `contracts/test/OracleTest.sol`
    - `contracts/test/PathTest.sol`
    - `contracts/test/PoolAddressTest.sol`
    - `contracts/test/PositionValueTest.sol`
    - `contracts/test/TickLensTest.sol` deleted
- try/catch:
    - `contracts/lens/Quoter.sol`

## Starknet Incompatibility
- message data: Starknet does not support msg.data. Files:
    - `contracts/openzeppelin/contracts/utils/Context.sol`
- v2: Contracts that use v2 are not needed
    - `contracts/v3Migrator.sol` This is to migrate from v2 to v3, no needed so deleted
    - `contracts/interfaces/IV3Migrator.sol` deleted
    - `contracts/lens/QuoterV2.sol`

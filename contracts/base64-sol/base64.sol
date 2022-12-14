// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

/// @title Base64
/// @author Brecht Devos - <brecht@loopring.org>
/// @notice Provides a function for encoding some bytes in base64
library Base64 {
    function encode(bytes memory data) internal pure returns (string memory) {
        return encode_internal(data);
    }

  /// warp-cairo
  /// from starkware.cairo.common.bitwise import bitwise_and
  /// from starkware.cairo.common.math_cmp import is_le_felt
  /// from warplib.maths.utils import felt_to_uint256
  /// from warplib.maths.div import warp_div
  /// from warplib.dynamic_arrays_util import felt_array_to_warp_memory_array
  /// from warplib.memory import wm_new
  /// from warplib.memory import wm_dyn_array_length
  /// from warplib.memory import wm_index_dyn
  /// from warplib.memory import wm_write_felt
  ///
  /// func INTERNALFUNC(encode_internal){range_check_ptr: felt, bitwise_ptr : BitwiseBuiltin*, warp_memory: DictAccess*}(data: felt) -> (felt){
  ///     alloc_locals;
  ///     let (data_len256) = wm_dyn_array_length(data);
  ///     let (data_len) = narrow_safe(data_len256);
  ///     let (resp_len) = INTERNALFUNC(compute_resp_len)(data_len);
  ///     let (resp_len256) = felt_to_uint256(resp_len);
  ///     let (resp) = wm_new(resp_len256, Uint256(1, 0));
  ///     
  ///     let (checked_encoded6_len) = INTERNALFUNC(encode_6bits)(data=data, data_index=0, resp=resp, resp_index=0, mod_3=0, prev=0);
  ///     assert checked_encoded6_len = resp_len;
  ///     let (checked_encoded8_len) = INTERNALFUNC(bits6_to_bits8)(resp, 0);
  ///     assert checked_encoded8_len = resp_len;
  ///     
  ///     return (resp,);
  /// }
  function encode_internal(bytes memory data) private pure returns (string memory) {
    // These functions are called here to let know warp that they will be used.
    // If no calls are made, those functions will not be in the program's workflow and
    // will not be transpiled.
    compute_resp_len(0);
    encode_6bits("0x00", 0, "0x00", 0, 0, 0);
    get_8_bit_representation(0);
    bits6_to_bits8("0x00", 0);
    return "0x00";
  }

  /// warp-cairo
  /// func INTERNALFUNC(compute_resp_len){range_check_ptr: felt}(data_size: felt) -> (felt){
  ///     let (div) = warp_div(data_size, 3);
  ///     let remain = data_size - (div*3);
  ///     if (remain == 0) {
  ///         return (div * 4,);
  ///     }
  ///     return ((div + 1) * 4,);  
  /// }
  function compute_resp_len(uint data_size) private pure returns (uint) {
    return 0;
  }

  /// warp-cairo
  /// func INTERNALFUNC(encode_6bits){
  ///     range_check_ptr: felt, 
  ///     bitwise_ptr: BitwiseBuiltin*, 
  ///     warp_memory: DictAccess*
  /// }(
  ///     data: felt, data_index: felt, resp: felt, 
  ///     resp_index: felt, mod_3: felt, prev: felt
  /// ) -> (felt) {
  ///     alloc_locals;
  ///     let (data_len256) = wm_dyn_array_length(data);
  ///     let (data_len) = narrow_safe(data_len256);
  ///     if (data_index == data_len) {
  ///         if (mod_3 == 1) {
  ///             // append 4 0's to prev 2 bits
  ///             wm_write_felt(resp + 2 + resp_index, prev*16);
  ///             // write 2 paddings
  ///             wm_write_felt(resp + 2 + resp_index+1, 100);
  ///             wm_write_felt(resp + 2 + resp_index+2, 100);
  ///             return (resp_index + 3,);
  ///         }
  ///         if (mod_3 == 2) {
  ///             // append 2 0's to prev 2 bits
  ///             wm_write_felt(resp + 2 + resp_index, prev*4);
  ///             // write 1 padding
  ///             wm_write_felt(resp + 2 + resp_index+1, 100);
  ///             return (resp_index + 2,);
  ///         }
  ///         return (resp_index,);
  ///     }
  ///     
  ///     let (element) = wm_read_felt(data + 2 + data_index);
  ///     if(mod_3 == 0) {
  ///         let (meaning_bits) = bitwise_and(element, 252); // 1111 1100
  ///         let (to_pass) = bitwise_and(element, 3);  // 0000 0011
  ///         tempvar to_add = meaning_bits / 4;
  ///         wm_write_felt(resp + 2 + resp_index, to_add);
  ///         return INTERNALFUNC(encode_6bits)(data, data_index+1, resp, resp_index+1, mod_3=1, prev=to_pass);
  ///     }
  ///     if(mod_3 == 1) {
  ///         let (meaning_bits) = bitwise_and(element, 240); // 1111 0000
  ///         let (to_pass) = bitwise_and(element, 15);  // 0000 1111
  ///         tempvar to_add_h = prev * 16;
  ///         tempvar to_add_l = meaning_bits / 16;
  ///         tempvar to_add = to_add_h + to_add_l;
  ///         wm_write_felt(resp + 2 + resp_index, to_add);
  ///         return INTERNALFUNC(encode_6bits)(data, data_index+1, resp, resp_index+1, mod_3=2, prev=to_pass);
  ///     }
  ///     if(mod_3 == 2) {
  ///         let (meaning_bits) = bitwise_and(element, 192); // 1100 0000
  ///         let (to_add2) = bitwise_and(element, 63);  // 0011 1111
  ///         tempvar to_add_h = prev * 4;
  ///         tempvar to_add_l = meaning_bits / 64;
  ///         tempvar to_add1 = to_add_h + to_add_l;
  ///         wm_write_felt(resp + 2 + resp_index, to_add1);
  ///         wm_write_felt(resp + 2 + resp_index+1, to_add2);
  ///         return INTERNALFUNC(encode_6bits)(data, data_index+1, resp, resp_index+2, mod_3=0, prev=0);
  ///     }
  ///     return (resp_index,);
  /// }
  function encode_6bits(bytes memory data, uint data_index, bytes memory resp, uint resp_index, uint mod_3, uint prev) private pure returns (uint) {
    return 0;
  }

  /// warp-cairo
  /// func INTERNALFUNC(get_8_bit_representation){range_check_ptr: felt}(num: felt) -> (felt) {
  ///     if (is_le_felt(num,25) == 1){
  ///         return (num + 65,); // ABC...YZ
  ///     }
  ///     if (is_le_felt(num,51) == 1){
  ///         return (num + 71,); // abc...yz
  ///     }
  ///     if (is_le_felt(num,61) == 1){
  ///         return (num - 4,); // 012...89
  ///     }
  ///     if (num == 62){
  ///         return (43,); // +
  ///     }
  ///     if (num == 63){
  ///         return (47,); // /
  ///     }
  ///     if (num == 100){
  ///         return (61,); // =
  ///     }
  ///     assert 1 = 2; // Should never get to this point
  ///     return (111111,); 
  /// }
  function get_8_bit_representation(uint num) private pure returns (uint) {
    return 0;
  }

  /// warp-cairo
  /// func INTERNALFUNC(bits6_to_bits8){range_check_ptr, warp_memory: DictAccess*}(data: felt, index: felt) -> (felt) {
  ///     alloc_locals;
  ///     let (data_len256) = wm_dyn_array_length(data);
  ///     let (data_len) = narrow_safe(data_len256);
  ///     if (data_len == index) {
  ///         return (index,);
  ///     }
  ///     let (element) = wm_read_felt(data + 2 + index);
  ///     let (to_add) = INTERNALFUNC(get_8_bit_representation)(element);
  ///     wm_write_felt(data + 2 + index, to_add);
  ///     return INTERNALFUNC(bits6_to_bits8)(data, index + 1);
  /// }
  function bits6_to_bits8(bytes memory data, uint index) private pure returns (uint) {
    return 0;
  }
}

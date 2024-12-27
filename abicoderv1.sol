pragma abicoder v1;

contract AbiDecoderV1 {
    function decode() public returns (uint128){
        bytes memory data = hex"ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";
        (uint128 value) = abi.decode(data, (uint128));
        return value;
    }
}

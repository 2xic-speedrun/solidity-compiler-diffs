contract Test {
    function test() public returns (uint256 a) {
        assembly {
            a := add(1,1)
            // adds many jumpdest opcodes.
            jumpdest()
            jumpdest()
            jumpdest()
        }
    }
}
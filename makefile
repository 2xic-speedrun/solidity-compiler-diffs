
build:
	cd solidity && ./scripts/build.sh

yul_jumpdest: build
	./solidity/build/solc/solc yul_test.sol --bin-runtime

abi_coderv2_testing: build
	# ./solidity/build/solc/solc abicoderv1.sol --optimize --via-ir --ir-optimized 
	./solidity/build/solc/solc abicoderv1.sol --optimize --via-ir --bin-runtime
	# ./solidity/build/solc/solc abicoderv1.sol --optimize --bin-runtime


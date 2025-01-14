solc compiler fun. Collection of some personal patches, mostly as a way to explore various part of the [solc codebase](https://github.com/ethereum/solidity). 

### Compiling
After applying a patch go into the `solidity` folder and run.
```bash
./scripts/build.sh
```

## Implicit casting for user defined types
Solidity doesn't allow you to do the following

```solidity
type UserType is uint256;

contract Example {
    function cast(uint256 test) internal returns (UserType) {
        return test;
    }
}
```

It will error with `Return argument type uint256 is not implicitly convertible to expected type (type of first return variable) UserType.`

However, this seems to just be a limit on the `TypeChecker` as the IR because if you patch the type checker you can get it to compile just fine.

To bypass just apply the patch and then compile
```bash
./generate_implicit_user_type_casting.sh apply
```

## Implicit casting of structs
Similarly to above, the following is not allowed in solc.

```solidity
struct A {
    address value;
}

struct B {
    address value;
}

contract Example {
    function cast(A memory test) internal returns (B memory) {
        return test;
    }

    function cast(B memory test) internal returns (A memory) {
        return test;
    }
}
```

To bypass just apply the patch and then compile
```bash
./generate_implicit_struct_casting.sh apply
```

## Fixing issue with abi decoder
I have this [open issue](https://github.com/ethereum/solidity/issues/15562) and was wondering how hard it would be to have some workaround (doesn't need to be a super clean one).

Actually, I can just remove the validator code.

```bash
./disable_abicoderv2_validation.sh apply
```

## Adding new yul functions
See the `new_yul_functions.diff` which adds a `jumpdest` yul function. This obviously isn't useful for anything special without a `jump` function also (and also `pc`) :D, but was done to see how easy / hard it would be to add custom functions to the yul language.

It was surprisingly easy to add a new function.

```bash
./generate_new_yul_functions.sh apply
```

## Backporting standard JSON interface
```bash
./generate_standard_jsons_diff.sh apply
```

Will give you the standard JSON for Solc version 0.4.0v (originally introduced in version 0.4.13) with some caveats.

```bash
cat ../standard_json_example.json | ./build/solc/solc --standard-json
```

## Disable the full inliner side effects safeguard
(per this old [bug](https://soliditylang.org/blog/2023/07/19/full-inliner-non-expression-split-argument-evaluation-order-bug/))

```bash
./disable_full_inliner_side_effects_safeguard.sh apply
```


```bash
./solidity/build/solc/solc --optimize --strict-assembly inliner_test.sol --ir-optimized --bin
```

Does not match the same behavior as 

```bash
./solidity/build/solc/solc --yul-optimizations="i" --optimize --strict-assembly inliner_test.sol --ir-optimized --bin
```

## on demand lsp (wip)
```bash
./scripts/build.sh  && cat ../lsp_example.json |  build/solc/solc  --lspio 
```

The idea was to be able to leverage the solc LSP without having to run it as a server. However, I quickly found out that the solc compiler doesn't have the [autocomplete support](https://github.com/ethereum/solidity-website/blob/470b92b5d6d442898ac26918e9374556f382f42d/src/posts/2021-12-20-solidity-0.8.11-release-announcement.md?plain=1#L37) so ended up not completing this.

Content of the `lsp_example.json` should be a lsp command.

```json
{
	"jsonrpc": "2.0",
	"id": 1,
	"method": "textDocument/didOpen",
	"params": {}
}
```

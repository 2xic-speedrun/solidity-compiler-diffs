solc compiler fun. Collection of some personal patches, mostly to explore various part of the [solc codebase](https://github.com/ethereum/solidity). 

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

## Fixing issue with abi decoder
I have this [open issue](https://github.com/ethereum/solidity/issues/15562) and was wondering how hard it would be to have some workaround (doesn't need to be a super clean one).

So the issue is in the IR generation and not the actual optimization step of the IR, I disabled all the optimization steps and it still generate invalid code. So we go into the `IRGeneratorForStatements.cpp` and I think the issue is inside there somewhere with the decode function.

Messing around with the generated IR code, we can remove the cleanup and revert functions (`validator_revert_t_uint128`), but we still don't get the full output out. Actually, if we just change `cleanup_t_uint128` to not do the `and` we get the correct output out.

Actually, I can just remove the validator code.

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

## Adding new yul functions
See the `new_yul_functions.diff` which adds a `jumpdest` yul function. This obviously isn't useful for anything special without a `jump` function also (and also `pc`) :D. 

It was suppringlsy easy to add a new function.

```bash
./generate_new_yul_functions.sh apply
```

## Backporting standard JSON interface
```bash
./generate_standard_jsons_diff.sh apply
```

Will give you the standard JSON for Solc version 0.4.0v (originally introduced in version 0.4.13).

```bash
cat ../standard_json_example.json | ./build/solc/solc --standard-json
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

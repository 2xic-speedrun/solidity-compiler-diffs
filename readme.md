solc compiler fun. 

### Compiling
```bash
mkdir build
cd build
cmake .. -DUSE_Z3=OFF && make
```

You might need to update `buildinfo.cmake` after such a change depending on what your are doing.

## Project brining back standard json to older versions of solc
Can I bring the standard JSON interface to the people ? 

```bash
cat ../../standard_json_example.json | ./solc/solc --standard-json 
```

- https://github.com/ethereum/solidity/pull/1639/files#diff-1799ee26c0dcd984c33a6f0471cc00a989c168635518b441cb3aa240da25ca81
- https://github.com/ethereum/solidity/compare/v0.4.0...v0.4.13

Sometimes you get weird compiler errors
```cmake
add_compile_options(-Werror)
```

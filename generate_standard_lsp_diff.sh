# Commit I used to test htis
COMMIT="ae9bcabd954c20e9610a3f3fe64e24cbcf153375"
mkdir -p .reference 
if [ ! -d ".reference/solidity" ]; then
    cd .reference && git clone https://github.com/ethereum/solidity
fi
cd ".reference/solidity" && git checkout "$COMMIT" && cd ../..
diff -r ".reference/solidity/" "./fun-with-lsp/" > "lsp_testing.diff"

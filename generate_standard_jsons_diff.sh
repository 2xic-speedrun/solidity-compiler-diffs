TAGS="0.4.0"
mkdir -p .reference 
if [ ! -d ".reference/solidity" ]; then
    cd .reference && git clone https://github.com/ethereum/solidity
fi
cd ".reference/solidity" && git checkout "tags/v$TAGS" && cd ../..
diff -r "./.reference/solidity/" "./solidity-$TAGS/" > "standard_json_support_${TAGS}.diff"

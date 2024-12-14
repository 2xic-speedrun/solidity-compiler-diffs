# Commit I used to test this
COMMIT="ae9bcabd954c20e9610a3f3fe64e24cbcf153375"
DIFF_NAME="lsp_testing.diff"
action=$1

if [ ! -d "solidity" ]; then
    git clone https://github.com/ethereum/solidity
fi

if [ "$action" == "generate" ]; then
    cd "solidity" && git diff > ../$DIFF_NAME
    echo " ../$DIFF_NAME"
elif [ "$action" == "apply" ]; then
    cd "solidity" && git apply ../$DIFF_NAME
else
    echo "Invalid input. Please enter 'generate' or 'apply'."
    exit 1
fi

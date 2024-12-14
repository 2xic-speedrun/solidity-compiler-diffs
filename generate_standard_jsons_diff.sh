TAGS="v0.4.0"
DIFF_NAME="standard_json_support_0.4.0.diff"
action=$1

if [ ! -d "solidity" ]; then
    git clone https://github.com/ethereum/solidity
fi

if [ "$action" == "generate" ]; then
    cd "solidity" && git diff > ../$DIFF_NAME
    echo " ../$DIFF_NAME"
elif [ "$action" == "apply" ]; then
    cd "solidity" && git checkout $TAGS && git apply ../$DIFF_NAME
else
    echo "Invalid input. Please enter 'generate' or 'apply'."
    exit 1
fi

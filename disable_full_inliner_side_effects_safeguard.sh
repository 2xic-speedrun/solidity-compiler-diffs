# Commit I used to test this
COMMIT="e0ab0f28206dcd1dfc3bb5e4a54bb6ef929caec5"
DIFF_NAME="disable_full_inliner_side_effects_safeguard.diff"
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

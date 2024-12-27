# Commit I used to test this
COMMIT="084d05e840d5101677a77468eed83da01a0731d0"
DIFF_NAME="disable_abicoderv2_validation.diff"
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

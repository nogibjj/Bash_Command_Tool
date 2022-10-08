#!/usr/bin/env bash

# datafactory.sh generates noises data that is in range [0, SCALE) and save to a specified file.

# Set strict mode. Cause shell to exit when a command fails.
set -e

# Set viriables.
USAGE="Usage: ./datafactory --gennoise COUNT --file FILENAME(default: noise.txt) --scale SCALE(default: 1000)"
DIGITS='^[0-9]+$'
FILE="noise.txt"
SCALE=1000

# Arguments check.
if [[ "$#" -lt "2" ]]; then
    echo "$USAGE"
    exit 1
fi


# Parse options.
while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    --gennoise)
    COUNT="$2"
    echo "count: $COUNT"
    if ! [[ $COUNT =~ $DIGITS ]]; then
        echo "Error: a number is missing for --gennoise"
        echo "$USAGE"
        exit 1
    fi
    shift
    ;;
    --file)
    FILE="$2"
    echo "processing $FILE"
    shift
    ;;
    --scale)
    SCALE="$2"
    echo "count: $SCALE"
    if ! [[ $SCALE =~ $DIGITS ]]; then
        echo "Error: a number is missing for --gennoise"
        echo "$USAGE"
        exit 1
    fi
    shift
    ;;
    *)
    echo "$key is not a valid flag"
    exit 1
    ;;
esac
shift
done

# Sanity check: --gennoise is a compulsary flag.
if [[ -z "$COUNT" ]]; then
    echo "flag --gennoise is missing"
    exit 1
fi

# Flush if previously exists.
if test -f "$FILE"; then
    rm -f $FILE
fi

# Generate random noise.
for ((i=0; i<$COUNT; i++)) do
    DATA=$(($RANDOM % $SCALE))
    echo $DATA >> $FILE
done

echo "$COUNT noises is generated in $FILE"
exit 1
#!/bin/bash

if [ "$1" == "" ]
then
    echo "No input file given"
    exit 1
fi

set -o errexit
set -o pipefail
set -o nounset

function cleanup()
{
    echo "Deleting ${OUT_DIR}..."
    rm -rf "$OUT_DIR"
}
trap cleanup EXIT

readonly IN_FILE="$1"
readonly OUT_DIR="$(mktemp --directory)"
readonly OUT_FILE="${OUT_DIR}/$(basename "${IN_FILE}" | sed 's/\.gpg$//')"

gpg --decrypt --yes -o "$OUT_FILE" "$IN_FILE"
echo "Opening ${OUT_FILE}..."
nvim "$OUT_FILE"
gpg --encrypt --sign --yes -o "$IN_FILE" "$OUT_FILE"

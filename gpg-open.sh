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
    rm -rf "${OUT_DIR}"
}
trap cleanup EXIT

readonly IN_FILE="$1"
readonly OUT_DIR="$(mktemp --directory)"
readonly OUT_FILE="${OUT_DIR}/$(basename "${IN_FILE}" | sed 's/\.gpg$//')"

gpg --decrypt --yes --output "${OUT_FILE}" "${IN_FILE}"
readonly OLD_MODIFY="$(stat --format="%Y" "${OUT_FILE}")"
echo "Opening ${OUT_FILE}..."
nvim "${OUT_FILE}"
readonly NEW_MODIFY="$(stat --format="%Y" "${OUT_FILE}")"
if [ "${OLD_MODIFY}" -ne "${NEW_MODIFY}" ]
then
    echo "File modified. Reencrypting..."
    gpg --encrypt --sign --yes --output "${IN_FILE}" "${OUT_FILE}"
else
    echo "File not modified"
fi

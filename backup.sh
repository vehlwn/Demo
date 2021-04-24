#!/bin/bash

readonly SOURCE_DIR="/mnt/e/1/0 /home/vehlwn"
readonly LUKS_DEVICE="/dev/sda3"
readonly MAPPING_NAME="cryptbackup"

set -o errexit
set -o pipefail
set -o nounset

function cleanup()
{
    if [ "${SHOULD_UMOUNT}" == "1" ]; then
        echo "Umounting..."
        umount "/mnt/${MAPPING_NAME}"
        cryptsetup close "${MAPPING_NAME}"
    fi
}
trap cleanup EXIT

SHOULD_UMOUNT="0"
if [ ! -e "/dev/mapper/${MAPPING_NAME}" ]; then
    echo "Mounting..."
    cryptsetup open "${LUKS_DEVICE}" "${MAPPING_NAME}"
    mkdir --parents "/mnt/${MAPPING_NAME}"
    mount "/dev/mapper/${MAPPING_NAME}" "/mnt/${MAPPING_NAME}"
    SHOULD_UMOUNT="1"
fi

readonly BACKUP_DIR="/mnt/${MAPPING_NAME}/backup"
readonly OPTS="--archive --acls --xattrs --human-readable --partial --one-file-system --delete --progress --verbose"
readonly DATETIME="$(date '+%Y-%m-%dT%H:%M:%S')"
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="${BACKUP_DIR}/latest"

mkdir -p "${BACKUP_DIR}"
rsync ${OPTS} \
  --link-dest "${LATEST_LINK}" \
  ${SOURCE_DIR} \
  "${BACKUP_PATH}"
ln --symbolic --force --no-target-directory "${BACKUP_PATH}" "${LATEST_LINK}"

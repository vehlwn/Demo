#!/bin/bash

readonly SOURCE_DIR="/mnt/e/1/0 /home/vehlwn /etc"
readonly LUKS_DEVICE="/dev/sda3"
readonly MAPPING_NAME="cryptbackup"

set -o errexit
set -o pipefail
set -o nounset

function cleanup()
{
    if [ "${SHOULD_UMOUNT}" = "1" ]; then
        echo "Umounting..."
        umount "/mnt/${MAPPING_NAME}"
        cryptsetup close "${MAPPING_NAME}"
    fi
    if [ "${SUCCESS}" = "0" ]; then
        echo "Failed to create backup. Removing ${BACKUP_PATH}..."
        rm --recursive "${BACKUP_PATH}"
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
readonly OPTS="--archive --human-readable -hh --one-file-system --delete --progress --verbose"
readonly DATETIME="$(date '+%Y-%m-%dT%H:%M:%S')"
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="${BACKUP_DIR}/latest"
SUCCESS="0"

mkdir -p "${BACKUP_DIR}"
rsync ${OPTS} \
  --link-dest "${LATEST_LINK}" \
  ${SOURCE_DIR} \
  "${BACKUP_PATH}"
ln --symbolic --force --no-target-directory "${BACKUP_PATH}" "${LATEST_LINK}"
SUCCESS="1"

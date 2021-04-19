#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

function cleanup()
{
    if [ "${SHOULD_UMOUNT}" == "1" ]; then
        echo "Umounting..."
        umount /mnt/cryptbackup
        cryptsetup close cryptbackup
    fi
}
trap cleanup EXIT

SHOULD_UMOUNT="0"
if [ ! -e /dev/mapper/cryptbackup ]; then
    echo "Mounting..."
    cryptsetup open /dev/sda3 cryptbackup
    mount /dev/mapper/cryptbackup /mnt/cryptbackup
    SHOULD_UMOUNT="1"
fi

readonly SOURCE_DIR="/mnt/e/1/0 /home/vehlwn"
readonly BACKUP_DIR="/mnt/cryptbackup/backup"

readonly OPTS="--archive --acls --xattrs --human-readable --partial --one-file-system --delete --progress --verbose"
readonly DATETIME="$(date --iso-8601=seconds)"
readonly BACKUP_PATH="${BACKUP_DIR}/${DATETIME}"
readonly LATEST_LINK="${BACKUP_DIR}/latest"

mkdir -p "${BACKUP_DIR}"
rsync ${OPTS} \
  --link-dest "${LATEST_LINK}" \
  ${SOURCE_DIR} \
  "${BACKUP_PATH}"
ln -sf "${BACKUP_PATH}" "${LATEST_LINK}"

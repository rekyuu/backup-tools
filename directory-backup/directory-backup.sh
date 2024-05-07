#! /bin/bash

export DIRECTORY_PATH="/data"

export BACKUP_NAME

export AWS_S3_BUCKET
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

function get_backup_filename {
    echo "${1}_backup_$(date +%s)"
}

backup_filename="$(get_backup_filename "${BACKUP_NAME}").tar.gz"
backup_filepath="/tmp/${backup_filename}"
s3_destination="s3://${AWS_S3_BUCKET}/${BACKUP_NAME}/${backup_filename}"

echo "Backing up ${DIRECTORY_PATH} to ${backup_filepath}" &&
cd "${DIRECTORY_PATH}" &&
tar zchf "${backup_filepath}" . &&

echo "Uploading to AWS: ${s3_destination}" &&
aws s3 mv "${backup_filepath}" "${s3_destination}" --only-show-errors

echo "Cleaning up"
rm "${backup_filepath}" 2> /dev/null

exit 0

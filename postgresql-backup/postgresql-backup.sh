#! /bin/bash

export PGHOST
export PGUSER
export PGPASSWORD

export AWS_S3_BUCKET
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

function get_backup_filename {
    echo "${1}_backup_$(date +%s)"
}

DATABASES=$(psql --quiet --no-align --tuples-only --command="SELECT datname FROM pg_database" | \
    grep -E -v "template0|template1|postgres")

for DATABASE in $DATABASES; do
    backup_filename="$(get_backup_filename "${DATABASE}").dump"
    backup_filepath="/tmp/${backup_filename}"
    s3_destination="s3://${AWS_S3_BUCKET}/${DATABASE}/${backup_filename}.gz"

    echo "Backing up database ${DATABASE} to ${backup_filepath}" &&
    pg_dump --format=c "${DATABASE}" > "${backup_filepath}" &&

    echo "Compressing to ${backup_filepath}.gz" &&
    gzip "${backup_filepath}" &&

    echo "Uploading to AWS: ${s3_destination}" &&
    aws s3 mv "${backup_filepath}.gz" "${s3_destination}" --only-show-errors

    echo "Cleaning up"
    rm "${backup_filepath}" 2> /dev/null
    rm "${backup_filepath}.gz" 2> /dev/null
done

# Backup Tools

Containers I've made to help with backing up stuff that needs backing up.

Both images will need the following environment variables to backup to AWS S3.

- `AWS_S3_BUCKET` - The name of the AWS S3 bucket to upload to
- `AWS_ACCESS_KEY_ID` - Get from AWS IAM
- `AWS_SECRET_ACCESS_KEY` - Get from AWS IAM

## Directory Backup

The directory you want to be backed up needs to be mounted to `/data`.

- `BACKUP_NAME` - The name of the backup

## PostgreSQL Backup

This will do a full backup of every database on the provided PostgreSQL server. Uses [PostgreSQL Environment Variables](https://www.postgresql.org/docs/current/libpq-envars.html) for connections.

- `PGHOST` - The database host server
- `PGPORT` - The database port
- `PGUSER` - The username to login as
- `PGPASSWORD` - The password for the user
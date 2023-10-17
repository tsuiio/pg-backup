#!/bin/sh
mc alias set backup_s3 "$S3_ENDPOINT" "$S3_ACCESS_KEY" "$S3_SECRET_KEY"
pg_dump -Fc -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" > /backup/"$BU_FILE_NAME".dump
mc cp --recursive /backup/"$BU_FILE_NAME"-"$(date +%Y-%m-%d)".dump backup_s3/"${S3_BUCKET}"/"${S3_PREFIX}"
exit 0
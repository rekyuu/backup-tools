FROM postgres:alpine

RUN apk add --no-cache aws-cli

COPY "postgresql-backup.sh" .
RUN ["chmod", "+x", "postgresql-backup.sh"]

ENTRYPOINT ["./postgresql-backup.sh"]
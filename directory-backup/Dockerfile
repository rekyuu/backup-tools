FROM alpine

RUN apk add --no-cache aws-cli bash

COPY "directory-backup.sh" .
RUN ["chmod", "+x", "directory-backup.sh"]

CMD ["./directory-backup.sh"]
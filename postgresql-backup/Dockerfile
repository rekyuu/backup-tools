FROM alpine

RUN apk add --no-cache aws-cli postgresql-client bash

COPY "postgresql-backup.sh" .
RUN ["chmod", "+x", "postgresql-backup.sh"]

CMD ["/bin/bash", "-c", "./postgresql-backup.sh"]
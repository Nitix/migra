FROM python:3.9-alpine

COPY . /tmp

RUN apk add --update --no-cache --upgrade postgresql-libs git && \
  apk add --no-cache --virtual=build-dependencies build-base postgresql-dev && \
  cd /tmp && \
  pip install --no-cache-dir . packaging psycopg2-binary && \
  apk del build-dependencies git && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["migra", "--help"]

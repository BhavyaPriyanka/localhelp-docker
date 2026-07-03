FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=root \
    MYSQL_USER=appuser \
    MYSQL_PASSWORD=localhelp \
    MYSQL_DATABASE=appdb

#RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

COPY scripts/*.sql /docker-entrypoint-initdb.d/
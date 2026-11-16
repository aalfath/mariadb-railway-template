# MariaDB for Railway: the official image, pinned by version and digest.
# Bump the tag and digest together, and add a CHANGELOG.md entry.
FROM mariadb:12.3.3@sha256:4ebbcf100a3ba320766dfa0e1af008df12261301db6ef72798c7650f70794aed

# Railway settings (data directory inside the volume, no DNS lookups on connect).
COPY railway.cnf /etc/mysql/conf.d/zz-railway.cnf

# Run mariadb-upgrade automatically when a newer image starts on an older data directory.
ENV MARIADB_AUTO_UPGRADE=1

EXPOSE 3306

# The base image's entrypoint (docker-entrypoint.sh) initialises the data directory
# on first start and creates MARIADB_DATABASE / MARIADB_USER.
CMD ["mariadbd"]

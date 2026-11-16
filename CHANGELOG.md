# Changelog

## 12.3.3 (2026-11-16)

- First release: MariaDB 12.3.3 LTS (`mariadb:12.3.3@sha256:4ebbcf100a3ba320766dfa0e1af008df12261301db6ef72798c7650f70794aed`).
- Data in `/var/lib/mysql/data` on a Railway volume, TCP proxy on port 3306, generated root and user passwords.
- `MARIADB_AUTO_UPGRADE=1`, so later image updates upgrade the system tables on their first start.

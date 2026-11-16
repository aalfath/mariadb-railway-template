[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/mariadb?utm_medium=integration&utm_source=button&utm_campaign=mariadb)

# MariaDB on Railway

A Railway template for [MariaDB Server](https://mariadb.org/), the open-source relational database that is compatible with MySQL.

- **Version:** MariaDB **12.3.3 LTS** (official `mariadb` image, pinned by version and digest in the [`Dockerfile`](Dockerfile)). Long-term support until June 2029.
- **Storage:** a Railway volume at `/var/lib/mysql`. The data lives in `/var/lib/mysql/data`, so the volume's `lost+found` folder never shows up as a database.
- **Network:** port 3306 on Railway's private network, plus a TCP proxy for clients outside Railway.
- **Credentials:** the root password and the application user's password are generated at deploy time. There are no default passwords.

## Variables

| Variable | Default | What it is |
|---|---|---|
| `MARIADB_ROOT_PASSWORD` | generated (32 characters) | Password of the `root` account |
| `MARIADB_USER` | `railway` | Application user, created on first start |
| `MARIADB_PASSWORD` | generated (32 characters) | Password of the application user |
| `MARIADB_DATABASE` | `railway` | Database created on first start; the application user owns it |
| `MARIADB_HOST` | `${{RAILWAY_PRIVATE_DOMAIN}}` | Private host name, for other services in the project |
| `MARIADB_PORT` | `3306` | Private port |
| `MARIADB_URL` | `mysql://…@${{RAILWAY_PRIVATE_DOMAIN}}:3306/…` | Connection URL over the private network |
| `MARIADB_PUBLIC_URL` | `mysql://…@${{RAILWAY_TCP_PROXY_DOMAIN}}:${{RAILWAY_TCP_PROXY_PORT}}/…` | Connection URL through the TCP proxy |
| `RAILWAY_DEPLOYMENT_DRAINING_SECONDS` | `60` | Gives MariaDB up to 60 s to shut down cleanly on a redeploy |

Other services connect with reference variables, for example `DATABASE_URL=${{MariaDB.MARIADB_URL}}`.

`MARIADB_USER`, `MARIADB_PASSWORD`, `MARIADB_DATABASE` and `MARIADB_ROOT_PASSWORD` only take effect on the first start, when the data directory is empty. To change a password later, run `ALTER USER` in SQL and then update the variable.

## Updates

Railway tells everyone who deployed this template when a change lands on this repo's `main` branch, and each deployer chooses when to apply it. Patch and LTS updates bump the image pin in the `Dockerfile`. `MARIADB_AUTO_UPGRADE=1` is set in the image, so MariaDB runs `mariadb-upgrade` on the first start after an update (it backs up the system tables first). Read [CHANGELOG.md](CHANGELOG.md) before you apply an update, and take a backup (`mariadb-dump`) first.

## Files

- `Dockerfile`: the pinned official image, the Railway config file and `MARIADB_AUTO_UPGRADE=1`.
- `railway.cnf`: sets the data directory inside the volume and turns on `skip-name-resolve`.

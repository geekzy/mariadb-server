# MariaDB Local Development Environment

This repository provides a containerized MariaDB setup using **Docker Compose**. It includes the official MariaDB Community Edition image and **phpMyAdmin** for a lightweight web-based administration interface.

## 📋 Prerequisites

Ensure the following are installed on your system:

* **Docker Desktop** (or Docker Engine + Docker Compose)
* **Make** (standard on Linux/macOS; use WSL or Git Bash on Windows)

## 🚀 Quick Start

To start the database and the admin UI immediately:

```bash
make up

```

Once running:

* **MariaDB Port:** `3306`
* **Admin UI:** [http://localhost:8081](http://localhost:8081)

## 🛠 Command Reference

We use a `Makefile` to simplify common Docker operations.

| Command | Description |
| --- | --- |
| `make up` | Starts MariaDB and phpMyAdmin in the background. |
| `make down` | Stops and removes the running containers. |
| `make restart` | Restarts the containers (useful for reloading config). |
| `make logs` | Tails the logs for the MariaDB container only. |
| `make shell` | Connects directly to the `mysql` CLI inside the container. |
| `make clean` | **WARNING:** Stops containers and **deletes** the persistent data volume. |

## ⚙️ Configuration Details

The stack is defined in `docker-compose.yml`.

### Credentials

Credentials are read from environment variables (see `.env.example`):

* **Root Password:** `MYSQL_ROOT_PASSWORD` (set in your local `.env`)

### Data Persistence

Data is persisted using a named Docker volume (`mariadb_data`).

* Running `make down` **preserves** your data.
* Running `make clean` **deletes** your data.

## 🔌 Connection Strings

### From Host Machine (Local Development)

Use this connection string for your local **Golang** or **Node.js** applications:

```text
root:passw0rd@tcp(localhost:3306)/

Replace `<username>` and `<password>` with the values from your `.env` file (or use the example in `.env.example`).

```

### From Inside Docker Network

If your application is running inside another Docker container on the same network (`app-network`), use the service name:

```text
root:passw0rd@tcp(mariadb:3306)/

Replace `<username>` and `<password>` with the values from your `.env` file (or use the example in `.env.example`).

```

## 📁 Project Structure

```text
.
├── docker-compose.yml  # Defines MongoDB and Mongo Express services
├── Makefile            # Shortcuts for Docker commands
└── README.md           # Documentation

```

## 📝 Integration Notes for Golang

Example MySQL/MariaDB configuration using `database/sql` with `github.com/go-sql-driver/mysql`:

```go
import (
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
)

db, err := sql.Open("mysql", "root:passw0rd@tcp(localhost:3306)/")
if err != nil {
    log.Fatal(err)
}
defer db.Close()
```

## 🔐 Environment

Create a local `.env` from `.env.example` and fill in the MongoDB credentials. The `.env` file is ignored by Git.

```bash
cp .env.example .env
# then edit .env and set:
# MONGO_INITDB_ROOT_USERNAME
# MONGO_INITDB_ROOT_PASSWORD
```

Run the stack using Docker Compose or the provided Makefile:

```bash
docker compose up -d
# or
make up
```

Admin UI (phpMyAdmin) will be available at [http://localhost:8081](http://localhost:8081) and MariaDB at port 3306.

Connection strings (replace with values from your `.env`):

```text
root:passw0rd@tcp(localhost:3306)/

# From inside the Docker network
root:passw0rd@tcp(mariadb:3306)/
```

If you want Docker Compose to render the effective configuration (helpful to verify env substitution):

```bash
docker compose config
```

If you prefer, remove the `version:` key from `docker-compose.yml` to avoid an informational warning on newer Compose versions.

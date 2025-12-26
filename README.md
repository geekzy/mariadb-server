# MongoDB Local Development Environment

This repository provides a containerized MongoDB setup using **Docker Compose**. It includes the official MongoDB Community Edition image and **Mongo Express** for a lightweight web-based administration interface.

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

* **MongoDB Port:** `27017`
* **Admin UI:** [http://localhost:8081](https://www.google.com/search?q=http://localhost:8081)

## 🛠 Command Reference

We use a `Makefile` to simplify common Docker operations.

| Command | Description |
| --- | --- |
| `make up` | Starts MongoDB and Mongo Express in the background. |
| `make down` | Stops and removes the running containers. |
| `make restart` | Restarts the containers (useful for reloading config). |
| `make logs` | Tails the logs for the MongoDB container only. |
| `make shell` | Connects directly to the `mongosh` CLI inside the container. |
| `make clean` | **WARNING:** Stops containers and **deletes** the persistent data volume. |

## ⚙️ Configuration Details

The stack is defined in `docker-compose.yml`.

### Credentials

* **Root Username:** `root`
* **Root Password:** `passw0rd`
* **Auth Database:** `admin`

### Data Persistence

Data is persisted using a named Docker volume (`mongodb_data`).

* Running `make down` **preserves** your data.
* Running `make clean` **deletes** your data.

## 🔌 Connection Strings

### From Host Machine (Local Development)

Use this connection string for your local **Golang** or **Node.js** applications:

```text
mongodb://root:passw0rd@localhost:27017/?authSource=admin

```

### From Inside Docker Network

If your application is running inside another Docker container on the same network (`app-network`), use the service name:

```text
mongodb://root:passw0rd@mongodb:27017/?authSource=admin

```

## 📁 Project Structure

```text
.
├── docker-compose.yml  # Defines MongoDB and Mongo Express services
├── Makefile            # Shortcuts for Docker commands
└── README.md           # Documentation

```

## 📝 Integration Notes for Golang

Example `mongo-driver` configuration:

```go
ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
defer cancel()

// DSN for local development
uri := "mongodb://root:passw0rd@localhost:27017/?authSource=admin"

client, err := mongo.Connect(ctx, options.Client().ApplyURI(uri))
if err != nil {
    log.Fatal(err)
}
```

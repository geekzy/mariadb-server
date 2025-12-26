# Usage: make [target]

.PHONY: up down restart logs shell clean

# Start all services in the background
up:
	@echo "🚀 Starting MariaDB stack..."
	docker-compose up -d
	@echo "✅ MariaDB: root@localhost:3306"
	@echo "✅ GUI:     http://localhost:8081"

# Stop containers
down:
	@echo "🛑 Stopping services..."
	docker-compose down

# Restart services
restart: down up

# View logs for MariaDB only
logs:
	docker-compose logs -f mariadb

# Enter the MariaDB shell (mysql client)
shell:
	@echo "🔌 Connecting to mysql client..."
	docker-compose exec mariadb mysql -u root -ppassw0rd

# Remove containers AND volumes (Fresh start)
clean:
	@echo "🗑️  Removing containers and data volumes..."
	docker-compose down -v
	@echo "✅ Cleaned."
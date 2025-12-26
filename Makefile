# Usage: make [target]

.PHONY: up down restart logs shell clean

# Start all services in the background
up:
	@echo "🚀 Starting MongoDB stack..."
	docker-compose up -d
	@echo "✅ MongoDB: mongodb://localhost:27017"
	@echo "✅ GUI:     http://localhost:8081"

# Stop containers
down:
	@echo "🛑 Stopping services..."
	docker-compose down

# Restart services
restart: down up

# View logs for MongoDB only
logs:
	docker-compose logs -f mongodb

# Enter the MongoDB Shell (mongosh)
shell:
	@echo "🔌 Connecting to Mongo Shell..."
	docker-compose exec mongodb mongosh -u root -p passw0rd --authenticationDatabase admin

# Remove containers AND volumes (Fresh start)
clean:
	@echo "🗑️  Removing containers and data volumes..."
	docker-compose down -v
	@echo "✅ Cleaned."
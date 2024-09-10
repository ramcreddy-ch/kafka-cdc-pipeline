# Kafka CDC Pipeline

A Change Data Capture (CDC) pipeline using Debezium, Kafka Connect, and Elasticsearch.

## Architecture

```
┌───────┐    ┌──────────┐    ┌───────┐    ┌──────────┐    ┌───────────────┐
│ MySQL │───▶│ Debezium │───▶│ Kafka │───▶│ ES Sink  │───▶│ Elasticsearch │
└───────┘    │Connector │    └───────┘    │Connector │    └───────────────┘
             └──────────┘                 └──────────┘
```

## Components

- **MySQL**: Source database with customers table
- **Debezium**: Captures row-level changes from MySQL binary log
- **Kafka**: Message broker
- **Elasticsearch**: Destination for search and analytics
- **Kibana**: Dashboard for visualization

## Prerequisites

- Docker & Docker Compose

## Quick Start

### 1. Start Infrastructure

```bash
docker-compose up --build -d
```

This will:
- Build a custom Kafka Connect image with Debezium and ES Connectors
- Start all services

### 2. Verify Connectors

Wait for services to be healthy (approx 1-2 mins), then submit the connectors:

```bash
cd scripts
./setup.sh
```

Or manually:

```bash
# Submit MySQL Source
curl -i -X POST -H "Content-Type:application/json" \
  http://localhost:8083/connectors/ -d @connectors/mysql-source.json

# Submit Elasticsearch Sink
curl -i -X POST -H "Content-Type:application/json" \
  http://localhost:8083/connectors/ -d @connectors/elasticsearch-sink.json
```

### 3. Test CDC

**Insert a new record in MySQL:**

```bash
docker exec -it mysql mysql -u root -ppassword inventory -e "INSERT INTO customers (first_name, last_name, email) VALUES ('Real', 'Time', 'real.time@example.com');"
```

**Verify in Elasticsearch:**

```bash
curl http://localhost:9200/dbserver1.inventory.customers/_search?pretty
```

You should see the new record indexed in Elasticsearch automatically.

## Updates & Deletes

- **Update**: Update a row in MySQL, the change propagates to ES.
- **Delete**: Delete a row in MySQL, Debezium sends a tombstone, and ES connector removes it (if configured).

## Author

Ramchandra Chintala

#!/bin/bash
# Submit connectors to Kafka Connect

echo "Waiting for Kafka Connect to start..."
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8083)" != "200" ]]; do 
  sleep 5
done

echo "Submitting MySQL Source Connector..."
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @../connectors/mysql-source.json

echo "Submitting Elasticsearch Sink Connector..."
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @../connectors/elasticsearch-sink.json

echo "Done."

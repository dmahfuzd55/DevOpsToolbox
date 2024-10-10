# docker-k6-grafana-influxdb
Demonstrates how to run load tests with containerised instances of K6, Grafana and InfluxDB.

#### To Run Project

sudo docker-compose up -d

docker-compose run k6 run /scripts/stress-test.js

docker-compose run k6 run /scripts/RMS/BeneficiaryValidation.js


Grafana Url
http://localhost:3000/

Influx DB Url 
http://localhost:8888/





# docker-k6-grafana-influxdb
Demonstrates how to run load tests with containerised instances of K6, Grafana and InfluxDB.

#### K6 Setup

Go to k6 project and check following files
```bash
ls

docker-compose.yml  grafana-dashboard.yaml  grafana-datasource.yaml  scripts
```


File and directory permission
```bash
sudo chown -R eai:eai /u01/devops/grafana/tcs/volumes/grafana/data/
```

run docker compose file
```bash
sudo docker-compose up -d
```

K6 project run

First go k6 project directory then run following command

```bash
docker-compose run k6 run /scripts/stress-test.js

# run project scripts
docker-compose run k6 run /scripts/RMS/BeneficiaryValidation.js
```


Grafana Url
```bash
http://localhost:3000/
```
Influx DB Url
```bash 
http://localhost:8888/
```




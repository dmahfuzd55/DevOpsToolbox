<h2 align="center">
Kafka Cluster Command and Usage Documentation
</h2>

#### zookeeper
```bash
kubectl apply -f zookeeper.yaml -n kafka
```

```bash
kubectl -n kafka get all -o wide
```

```bash
kubectl logs zookeeper-77d65cfcfc-4qm82 -n kafka
```

```bash
kubectl describe statefulsets -n kafka
```

```bash
kubectl logs kafka-broker-1 -n kafka
```
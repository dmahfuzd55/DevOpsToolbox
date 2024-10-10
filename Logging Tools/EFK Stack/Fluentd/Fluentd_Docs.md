<h2 align="center">
Fluentd Command and Usage Documentation
</h2>


Fluentd run on docker

docker run -d -p 24224:24224 -p 24224:24224/udp --name fluentd \
    -v $(pwd)/fluent.conf:/fluentd/etc/fluent.conf \
    fluent/fluentd:v1.14-1
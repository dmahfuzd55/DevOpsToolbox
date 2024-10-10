<h2 align="center">
Jenkins Command and Usage Documentation
</h2>


Jenkins docker image run command

Ensure that /data/jenkins/jenkins-data has the proper permissions (owned by the UID and GID that Jenkins uses inside the container, typically 1000:1000). You can adjust permissions as needed using:
```bash
sudo chown -R 1000:1000 /data/jenkins/jenkins-data
```
This setup will give you a Jenkins instance that is accessible from your host machine and whose data persists across container restarts or re-creations.


```bash
docker run \
  --name jenkins \
  --detach \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume /data/jenkins/jenkins-data:/var/jenkins_home \
  jenkins/jenkins:lts
```


Jenkins initial password

```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```


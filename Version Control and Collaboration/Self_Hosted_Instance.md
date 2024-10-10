<h2 align="center">
GitLab - Self Hosted Instance Documentation
</h2>

### Self Hosted Server Configuration

We can install and use GitLab locally on our own server or machine. This allows we to have a self-hosted GitLab instance within our own environment, providing we with control over the installation and configuration. Here's a simplified guide on how to install GitLab locally:

Prerequisites:

Server Requirements:

A machine or server with sufficient resources (RAM, CPU, storage).
Dependencies:

Ensure that the necessary dependencies are installed, such as Docker, Docker Compose, or the required packages for your operating system.
Steps:
1. Install Docker and Docker Compose (if not installed):
Follow the official Docker installation guide for your operating system: Get Docker
Follow the official Docker Compose installation guide: Install Docker Compose
2. Create a Docker Compose File:
Create a docker-compose.yml file with the following content:

```yaml
version: '13.3'

services:
  gitlab:
    image: gitlab/gitlab-ee:latest
    restart: always
    hostname: 'localhost'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://localhost'
    ports:
      - '80:80'
      - '443:443'
    volumes:
      - '/u01/devops/gitlab/volumes/config:/etc/gitlab'
      - '/u01/devops/gitlab/volumes/logs:/var/log/gitlab'
      - '/u01/devops/gitlab/:/var/opt/gitlab'
```
3. Configure GitLab:
Create a directory for GitLab data and configuration:
```bash
sudo mkdir -p /u01/devops/gitlab/volumes/config /u01/devops/gitlab/volumes/logs /u01/devops/gitlab/volumes/data
```
4. Run GitLab:
Run GitLab using Docker Compose:
```bash
sudo docker-compose up -d
```

5. Access GitLab:
Visit http://localhost in web browser. The first time we access GitLab, will be prompted to login

Username : root
Password : For root password run following command
```bash
sudo docker exec -it 5cb3abea6258 grep 'Password:' /etc/gitlab/initial_root_password
```

Follow the GitLab documentation for more advanced configurations and settings: [GitLab Docker Images](https://docs.gitlab.com/ee/install/docker.html)


### Project up to self hosted repository server

Git Initialization
```bash
git init
```
File Staging
```bash
git add .
```
Git Commit
```bash
git commit -m "Initial"
```
Local Repository connect with Remote Repository
```bash
git remote add origin http://172.8.9.41/dmahfuzd/test-project1.git
```
```bash
git push -u origin master
```







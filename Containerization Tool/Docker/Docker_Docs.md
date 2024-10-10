If you are using a Red Hat-based system like CentOS, you might need to enable the Docker repository first. You can do this by following the official Docker installation instructions. Here's a basic guide for CentOS:

Remove Old Versions (if installed):

```bash
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
```
Install Required Dependencies:

```bash
sudo yum install -y yum-utils \
                    device-mapper-persistent-data \
                    lvm2
```
Set Up Docker Repository:
```bash
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```
Install Docker Packages:

```bash
sudo yum install docker-ce docker-ce-cli containerd.io
```
Note: The packages docker-buildx-plugin and docker-compose-plugin are not standard Docker packages and are not typically installed via package managers like yum. You might need to install them separately following their respective installation instructions.

Always check the official Docker documentation for the most up-to-date instructions: Install Docker Engine on CentOS

After installation, you may need to start and enable the Docker service:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Docker Compose

1. Download the Docker Compose binary:
Run the following commands in your terminal to download the latest stable release of Docker Compose:
```bash
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```
1. Apply executable permissions to the binary:
```bash
sudo chmod +x /usr/local/bin/docker-compose
```
1. Verify the installation:
```bash
docker-compose --version
```

Specify the full path to the docker-compose executable:
```bash
sudo /usr/local/bin/docker-compose up -d
```
Replace /usr/local/bin/docker-compose with the actual path where your docker-compose executable is located.

Option 2: Adjust sudo's Secure Path
Edit the sudoers file to include the path where docker-compose is installed. Run the following command to open the sudoers file in edit mode:
```bash
sudo visudo
```
Add the following line to the file, adjusting the path based on your actual installation:
```bash
Defaults secure_path="/usr/local/bin:/usr/bin:/bin"
```
Save and exit the editor. This change ensures that sudo looks in the specified paths when executing commands.

After making these changes, you should be able to use sudo docker-compose without specifying the full path.

Option 3: Symlink to /usr/bin
Create a symbolic link to docker-compose in a directory that's in the PATH for sudo. For example:
```bash
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

Docker images push docker hub
-----------------------------
Tag your Docker image:

```bash
docker tag your_image_id dockerhub_username/your_image_name:tag
```
Replace your_image_id with the ID of your Docker image (you can get it using docker images), dockerhub_username with your Docker Hub username, your_image_name with the name you want to give to your Docker image on Docker Hub, and tag with the version or tag you want to assign.

Login to Docker Hub:

```bash
docker login
```
Enter your Docker Hub username and password when prompted.

Push the Docker image to Docker Hub:

```bash
docker push dockerhub_username/your_image_name:tag
```
Replace dockerhub_username, your_image_name, and tag with the values you used in step 1.

After these steps, your Docker image will be available on Docker Hub.

Here is a summary of the commands:

```bash
# Tag your Docker image
docker tag your_image_id dockerhub_username/your_image_name:tag

# Login to Docker Hub
docker login

# Push the Docker image to Docker Hub
docker push dockerhub_username/your_image_name:tag
```



Build Docker Image: Use the docker build command to build your Docker image. Make sure you're in the directory containing your Dockerfile.
```bash
docker build -t your-image-name:v1 .
```
Replace your-image-name with the name you want to give to your Docker image.

Tag the Docker Image: Tag your Docker image with the version.
```bash
docker tag your-image-name:v1 your-repository-name/your-image-name:v1
```
Replace your-repository-name with the address of your Docker repository (e.g., Docker Hub username or your private repository) and your-image-name with your image name.

Run build image

```bash
sudo docker run -d -p 8080:80 nginx:v1
```

```bash
sudo docker run -d \
  -p 3040:3040 \
  -e TCS_ENTPOINT_ENQUIRECUSTOMER="https://172.30.202.18:9430/EnquireCustomer/EnquireCustomerInterfaceHttpService" \
  -e TCS_ENDPOINT_SDMC="https://172.30.202.18:9430/SingleDebitMultiCredit/SingleDebitMultiCreditInterfaceHttpService" \
  -e TCS_ENDPOINT_SDMC_CORRECT="https://172.30.202.18:9430/SingleDebitMultiCredit5Correction/SingleDebitMultiCredit5CorrectionInterfaceHttpService" \
  eaijbl/banglaqr:v1
```

Create repository to docker registrary

Repository name will be like your-repository-name


Logint to repository
```bash
docker login

username: eaijbl
password: *Jbl@4567
```


Push Docker Image to Repository: Push your Docker image to the Docker repository.
```bash
docker push your-repository-name/your-image-name:v1
```
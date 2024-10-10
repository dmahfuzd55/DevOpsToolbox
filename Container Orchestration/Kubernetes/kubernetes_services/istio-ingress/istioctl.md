<h2 align="center">
Istio Command and Usage Documentation
</h2>

Steps to Install istioctl
Download Istio: First, download the version of Istio you want to use.

```bash
curl -L https://istio.io/downloadIstio | sh -
```
This will download the latest version of Istio. Alternatively, you can specify a particular version by using:

```bash
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.18.1 sh -
```
Add istioctl to your PATH: After downloading, navigate into the Istio directory that was downloaded, and add istioctl to your PATH:

```bash
cd istio-<version>
export PATH=$PWD/bin:$PATH
```
You can verify that istioctl is working by running:

```bash
istioctl version
```

Use istioctl to Install Istio: Now you can run your original command to install Istio with your custom IstioOperator configuration.

```bash
istioctl install -y -f - <<EOF
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: usergroup-1
spec:
  profile: minimal
  revision: usergroup-1
  meshConfig:
    discoverySelectors:
      - matchLabels:
          usergroup: usergroup-1
  values:
    global:
      istioNamespace: usergroup-1
EOF
```
Making the istioctl Path Persistent
If you want istioctl to be available every time you open a new terminal session, you can add the istioctl binary path to your shell configuration file (e.g., .bashrc, .zshrc):
```bash
echo 'export PATH=$HOME/istio-<version>/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```
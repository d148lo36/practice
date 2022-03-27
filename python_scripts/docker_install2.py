import os
import subprocess

print("-------------------- Uninstall old version of docker --------------------")

subprocess.run(["apt", "remove", "-y", "docker", "docker-engine", "docker.io", "containerd", "runc"], check=True)

print("-------------------- Prepare to install docker, get update from repo --------------------")

subprocess.run(["apt", "install", "-y", "ca-certificates", "curl", "gnupg", "lsb-release"], check=True)

print("-------------------- Add Docker official GPG key --------------------")

os.system('curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/docker-archive-keyring.gpg')

print("-------------------- Add stable repo --------------------")

os.system('echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null')

print("-------------------- Get update from repo --------------------")

subprocess.run(["apt", "update", "-y"], check=True)

pkg = "docker-ce docker-ce-cli containerd.io"

print("-------------------- Installing Docker --------------------")

subprocess.run(["apt", "install", "-y", "docker-ce", "docker-ce-cli", "containerd.io"], check=True)

print("-------------------- Done! --------------------")
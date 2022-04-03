import os
from re import sub
import subprocess
from colorama import Fore, Style

print(Fore.RED + "-------------------- Stopping docker service --------------------" + Style.RESET_ALL)

os.system("systemctl stop docker.socket")

os.system("systemctl stop docker.service")

print(Fore.GREEN + "-------------------- Prepare to install docker, get update from repo --------------------" + Style.RESET_ALL)

subprocess.run(["apt", "install", "-y", "ca-certificates",
               "curl", "gnupg", "lsb-release"], check=True)

print(Fore.GREEN + "-------------------- Add Docker official GPG key --------------------" + Style.RESET_ALL)

os.system('curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/docker-archive-keyring.gpg')

print(Fore.GREEN + "-------------------- Add stable repo --------------------" + Style.RESET_ALL)

os.system('echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null')

print(Fore.GREEN + "-------------------- Get update from repo --------------------" + Style.RESET_ALL)

subprocess.run(["apt", "update", "-y"], check=True)

print(Fore.GREEN + "-------------------- Installing Docker --------------------" + Style.RESET_ALL)

subprocess.run(["apt", "install", "-y", "docker-ce",
               "docker-ce-cli", "containerd.io"], check=True)

print(Fore.GREEN + "-------------------- Add docker group --------------------" + Style.RESET_ALL)

subprocess.run(["groupadd", "docker"])
os.system("usermod -aG docker $USER")

print(Fore.YELLOW + "-------------------- Starting docker service --------------------" + Style.RESET_ALL)

os.system("systemctl start docker")
os.system("systemctl enable docker")

print(Fore.GREEN + "-------------------- Test docker --------------------" + Style.RESET_ALL)

subprocess.run(["docker", "run", "hello-world"])

print(Fore.GREEN + "-------------------- Done! --------------------" + Style.RESET_ALL)

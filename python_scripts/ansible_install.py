import os
import subprocess
from colorama import Fore, Style

print(Fore.YELLOW + "-------------------- Get update from repo --------------------" + Style.RESET_ALL)

subprocess.run(["apt", "update", "-y"], check=True)

print(Fore.GREEN + "-------------------- Installing software-properties-common --------------------" + Style.RESET_ALL)

subprocess.run(["apt", "install", "-y", "software-properties-common"], check=True)

print(Fore.YELLOW + "-------------------- Add ansible repo --------------------" + Style.RESET_ALL)

subprocess.run(["add-apt-repository", "--yes", "--update", "ppa:ansible/ansible"], check=True)

print(Fore.GREEN + "-------------------- Install Ansible --------------------" + Style.RESET_ALL)

subprocess.run(["apt", "install", "-y", "ansible"], check=True)

print(Fore.GREEN + "-------------------- Done! --------------------" + Style.RESET_ALL)

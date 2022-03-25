import os

print("--------------- Prepare to install docker, get update from repo ---------------")

os.system('apt update')
os.system('apt -y install \
    ca-certificates \
        curl \
            gnupg \
                lsb-release')

print("--------------- Add Docker official GPG key ---------------")

os.system('curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg')

print("--------------- Add stable repo ---------------")
os.system('echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null')

print("--------------- Get update from repo ---------------")
os.system('apt update')
print("--------------- Installing Docker ---------------")
os.system('apt -y install docker-ce docker-ce-cli containerd.io')
import os
import shutil

src = "/home/alex/practice/files"
dest = "/var/www/html"

print("-------------------- Install nginx and copy files to /var/www/html --------------------")
os.system('apt update')
os.system('apt -y install nginx')
print("-------------------- Configuration firewall --------------------")
os.system('ufw app list')
os.system("ufw allow 'Nginx HTTP'")
os.system('ufw status')
print("-------------------- Checking your Web server --------------------")
os.system('systemctl status nginx')
print("-------------------- Copy files from " + src + " to " + dest + " --------------------")
src_files = os.listdir(src)
for file_name in src_files:
    full_file_name = os.path.join(src, file_name)
    if os.path.isfile(full_file_name):
        shutil.copy(full_file_name, dest)
print("-------------------- Restart Nginx web server --------------------")
os.system('service nginx restart')
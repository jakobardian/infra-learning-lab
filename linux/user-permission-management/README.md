# User and Permission Management

---

## Overview
Dokumen ini berisi praktik dasar administrasi user, group, dan permission di Linux,
termasuk automation sederhana menggunakan shell script. Lab ini bertujuan untuk memiliki pengalaman 
praktik langsung dan memahami konsep user acces management dalam sistem Linux. 

---

## Environment
- OS: Ubuntu 24.04
- Shell: Zsh
- Tools: useradd, groupadd, usermod, passwd, chmod, chown, journalctl

---

## Scenario
- Users                : Vanny, Chella, Grace, Stacey, Maureen, Gabriella, Stella, Sherly, Felicia, Michelle, Jessyln
                         Vanessa, Aurelia, Clarissa, Shania, Zoey, Audrey, Olive, Ashley, Tiffany
- Groups               : Developer, Database, Operation
- Working Direectory   : /var/projects/learning-demo-app

---

## Steps
### 1. Create User Accounts
Manual Command
```zsh
sudo useradd -m -s /bin/zsh [user_name]
```
Automation Command
```zsh
while read -r user; do sudo useradd -m -s /bin/zsh "$user" done < users.txt
```
Verification
```zsh
getent passwd [user_name]
```
Delete User
```zsh
sudo userdel -r [user_name]
```
- (-m)          : Otomatis membuat home directory
- (-s)          : Menentukan default login shell
- Note          : Automation mode harus memiliki file list user dalam bentuk users.txt
---
### 2. Set User Password 
Manual Command: 
```zsh
sudo passwd [user_name]
```
Automation Command
```zsh
echo "[user_name]:[password]" | sudo chpasswd
```
Delete Password
```zsh
sudo passwd -d [user_name]
```
---
### 3. Create and Manage Groups
Manual Command
```zsh
sudo groupadd [group_name]
```
Automation Command
```zsh
sudo groupadd [group_name] || true
```
Verification
```zsh
getent group [group_name]
```
Delete Group
```zsh
sudo groupdel [group_name]
```
- || true: Script tetap jalan walaupun group sudah ada 
---
### 4. Assign User to Groups
Command
```zsh
sudo usermod -aG [group_name] [user_name]
```
Verification
```zsh
id [user_name]
```
Remove User from Group
```zsh
sudo deluser [user_name] [group_name]
```
- (-aG): Menambahkan user ke group tanpa menghapus membership group lain
---
### 5. Set Ownership, and Directory Permissions
Build Folder/Directory
```zsh
sudo mkdir -p /var/project/[folder_name]
```
Set Ownership
```zsh
sudo chown [user_name]:[group_name] /var/project/[folder_name]
```
Set Permission
```zsh
sudo chmod [permission_code] /var/project/[folder_name]
```
Verification
```zsh
ls -ld /var/project/[folder_name]
```
- Contoh permission code 770:rwxrwx---
---
### 6. Verify Permissions and User Access
Step:
- Login sebagai owner > action Read/Write/Execute > Expected succes
- Login sebagai member group > action Read/Write/Execute > Expected succes
- Login sebagai non owner & non member group > action Read/Write/Execute > Expected failed

Command 1
```zsh
sudo -u [user_name] [action] [folder_name]/[file_name]
```
Command 2
```zsh
su - [user_name] -c [action] [folder_name]/[file_name]
```
- Command 1: versi cepat dan praktis
- Command 2: versi environment user target lengkap
---
### 7. Audit with Logs
Audit - SSH Login
```zsh
sudo journalctl -u ssh
```
Audit - Error & Failure System
```zsh
sudo journalctl -xe
```
Audit - Failed
```zsh
sudo journalctl | grep -i failed
```
Audit - Denied
```zsh
sudo journalctl | grep -i denied
```
Audit - Permission Denied & File Access - Kernel level denial
```zsh
sudo journalctl -k | grep -i denied
```
Audit - Permission Denied & File Access - Kernel real-time log 
```zsh
sudo dmesg | grep -i denied
```
Audit - Sudo Activity
```zsh
sudo cat /var/log/auth.log | grep sudo
```
```zsh
sudo journalctl | grep sudo
```
---
### 8. Cleanup
Remove User
```zsh
sudo userdel -r [user_name]
```
Delete User Automation
```zsh
for user in [user1] [user2] [user3]; do sudo userdel -r "$user"; done
```
Remove Group
```zsh
sudo groupdel [group_name]
```
Remove Directory
```zsh
sudo rm -rf [directory_name]
```
- (-r): menghapus home directory juga
- (-rf): hapus paksa directory

---

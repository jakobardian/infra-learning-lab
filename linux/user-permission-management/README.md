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
while read -r user; do
    sudo useradd -m -s /bin/zsh "$user"
done < users.txt
```

- (-m)          : Otomatis membuat home directory
- (-s)          : Menentukan default login shell
- Note          : Automation mode harus memiliki file list user dalam bentuk users.txt
- Verification  : **getent passwd [user_name]**
- Cleanup       : **sudo userdel -r [user_name]**


### 2. Set User Password 
Membuat password untuk user baru

Command1: **sudo passwd [user_name]**
- Delete password: **sudo passwd -d [user_name]**


3. Create and Manage Groups
Membuat group

Command1: **sudo groupadd [group_name]**
Command2: **sudo groupadd [group_name] || true**

- || true: mode automation
- Check command: **getent group [group_name]**
- Delete group: **sudo groupdel [group_name]**


4. Assign User to Groups
Menambahkan user ke group

Command: **sudo usermod -aG [group_name] [user_name]**

- (-aG): Menambahkan user ke group tanpa menghapus membership group lain
- Check: **id [user_name]**
- Delete user from group: **sudo deluser [user_name] [group_name]**


5. Set Ownership, and Directory Permissions
Mengatur hak akses pada file atau direktori

Make file      : **sudo mkdir -p /var/project/learning-demo-app**
Set ownership  : **sudo chown [user_name]:[group_name] /var/project/learning-demo-app**
Set permission : **sudo chmod 770 /var/project/learning-demo-app**

- 770:rwxrwx---
- Check command: ls -ld [file_name]


6. Verify Permissions and User Access
Validasi Akses File dari Masing-masing User

Step:
- Login sebagai user owner > do Read/Write/Execute > Expected succes
- Login sebagai member group owner > do Read/Write/Execute > Expected succes
- Login sebagai non member group & non user owner > do Read/Write/Execute > Expected failed

Command1: **sudo -u [user_name] "command" [Read/Write/Execute] [folder_name]/[file_name]
Command2: **su - [user_name] -c "command" [Read/Write/Execute] [folder_name]/[file_name]


7. Audit with Logs
# Login, Logout, and Authentication Logs
## aktivitas login, logout, dan gagl autentikasi
Command1: **sudo journalctl -u ssh**
Command2: **sudo journalctl -xe**
## aktivitas mencurigakan atau gagal login
Command: **sudo journalctl | grep -i "failed"**
         **sudo journalctl | grep -i "denied"**

# Permission Denied & File Access Audit
## Aktivitas user gagal membaca, menulis, atau membuat file
Command1: **sudo journalctl -k | grep -i denied**
Command2: **sudo dmesg | grep -i denied**

# Sudo Activity Audit
Command1: **sudo cat /var/log/auth.log | grep sudo**
COmmand2: **sudo journalctl | grep sudo**


8. Cleanup 
Remove user: sudo userdel -r [user_name]
- (-r): menghapus home directory juga
Remove group: **sudo groupdel [group_name]**
Remove directory: **sudo rm -rf [directory_name]**
- (-rf) hapus paksa directory
- Delete user automation: **for user in [user1] [user2] [user3]; do sudo userdel -r "$user"; done**

Verify
getent passwd | grep -E [user_name]
getent group | grep -E [group_name]
ls -ld [directory_name]


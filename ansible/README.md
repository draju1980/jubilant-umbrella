How to run this Playbook
==============
To execute the Ansible playbook on the target Linux box, follow these steps:

1.	Login to the Linux Box:
SSH into the Linux box where you want to execute the Ansible playbook.

2.	Switch to Root:
Switch to the root user using the following command:
```
sudo su -
```

3.	Install Ansible and Git:
Install Ansible and Git using the apt package manager:
```
sudo apt update
```
```
sudo apt install ansible git -y
```

4.	Clone Repository:
Clone the repository locally:
```
git clone https://github.com/draju1980/jubilant-umbrella.git
```

5.	Change Directory:
Change to the ansible directory:
```
cd jubilant-umbrella/ansible
```

6.	Run Ansible Playbook:
Run the Ansible playbook using the inventory file:

```
ansible-playbook -i inventory.ini tasks/main.yml
```

When running Ansible tasks on a remote node, ensure to update the inventory file with the remote node's IP address and authentication details.

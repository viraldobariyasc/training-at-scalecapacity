# Ansible Notes

## 1. About Ansible

### 1.1 What is Ansible?

Ansible is an open-source **automation and configuration management tool**.

It is mainly used to automate repetitive tasks on servers, such as:

- Installing software
- Configuring servers
- Managing services
- Creating users
- Deploying applications

Ansible is **agentless**, meaning we normally don't need to install an Ansible agent on Linux servers.

### 1.2 How Ansible Works

```text
        Control Node
     (Ansible installed)
             |
         Inventory
             |
         Playbook
             |
          SSH
             |
    +--------+--------+
    |        |        |
 Server 1 Server 2 Server 3
```

- **Control Node** → Machine where Ansible is installed.
- **Managed Nodes** → Servers managed by Ansible.
- **Inventory** → List of managed servers.
- **Playbook** → Defines what Ansible should do.
- **Modules** → Perform specific operations.

---

## 2. Use Cases

Common Ansible use cases:

| Use Case | Example |
|---|---|
| Configuration | Configure Nginx |
| Software Installation | Install Docker |
| Deployment | Deploy an application |
| User Management | Create Linux users |
| Service Management | Start/restart services |
| Patch Management | Update packages |
| Server Setup | Configure new EC2 instances |

### Example

Instead of manually installing Docker on 10 servers:

```text
Manual:
Server 1 → Install Docker
Server 2 → Install Docker
...
Server 10 → Install Docker
```

Ansible can automate the same task across all servers using one playbook.

---

## 3. Ansible and IaC

### 3.1 Important Point

Ansible **can be used as an IaC/automation tool**, but it is mainly known for **configuration management and automation**.

Terraform is mainly used for **provisioning infrastructure**.

```text
Terraform
   |
   +--> VPC
   +--> EC2
   +--> RDS
   +--> Load Balancer
          |
          v
       Ansible
          |
          +--> Install software
          +--> Configure server
          +--> Deploy application
```

### 3.2 Ansible vs Terraform

| | Ansible | Terraform |
|---|---|---|
| Main purpose | Configuration & automation | Infrastructure provisioning |
| Example | Install Nginx | Create EC2 |
| Language | YAML | HCL |
| State file | No Terraform-style state | Yes |
| Agent | Usually agentless | Provider-based |

**Real-world usage:** Terraform and Ansible are often used together rather than replacing each other.

---

## 4. Advantages of Ansible

- **Agentless** → No agent normally required on Linux managed nodes.
- **Simple** → Uses easy-to-read YAML.
- **Automation** → Removes repetitive manual work.
- **Idempotent** → Can maintain the desired state without unnecessarily repeating changes.
- **Large module library** → Modules are available for many common operations.
- **Easy to integrate** → Works well with CI/CD and cloud environments.
- **Scalable** → Can manage multiple servers.

---

## 5. Installing Ansible

### 5.1 Install on Ubuntu

```bash
sudo apt update
sudo apt install ansible -y
```

### 5.2 Verify Installation

```bash
ansible --version
```

Example:

```text
ansible [core 2.x.x]
  python version = 3.x.x
```

### 5.3 Test Ansible

```bash
ansible localhost -m ping -c local
```

Expected:

```text
localhost | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

The `ping` here is an **Ansible module**, not an ICMP network ping.

---

## 6. Important Components

### Inventory

Defines the servers Ansible manages.

```ini
[webservers]
web1 ansible_host=10.0.1.10
web2 ansible_host=10.0.1.11
```

### Playbook

Defines the automation tasks.

```yaml
- name: Install Git
  hosts: webservers
  become: true

  tasks:
    - name: Install Git
      apt:
        name: git
        state: present
```

### Modules

Modules perform the actual work.

Common modules:

- `apt` → Install packages
- `copy` → Copy files
- `file` → Manage files/directories
- `service` → Manage services
- `user` → Manage users
- `command` → Run commands

---

## 7. Common Mistakes

- Incorrect inventory configuration.
- Wrong SSH username or key.
- Port 22 blocked by Security Group/firewall.
- Using `shell` or `command` when an appropriate Ansible module exists.
- Storing passwords/secrets directly in playbooks.
- Running privileged tasks without `become`.

---

## 8. Best Practices

- Store Ansible code in Git.
- Use inventory groups to organize servers.
- Prefer modules over shell commands.
- Use `become` only when required.
- Keep secrets in Ansible Vault or a secret manager.
- Write idempotent playbooks.
- Test changes before applying them to production.

---

## 9. Interview Questions

1. What is Ansible?
2. Why is Ansible called agentless?
3. What is an Ansible inventory?
4. What is a playbook?
5. What is an Ansible module?
6. Ansible vs Terraform?
7. Can Ansible and Terraform be used together?

---

## 10. Summary

- Ansible automates server and application-related tasks.
- It is commonly agentless and uses SSH for Linux servers.
- **Inventory** → Defines servers.
- **Playbook** → Defines tasks.
- **Modules** → Perform operations.
- Ansible is mainly used for configuration and automation.
- Terraform is mainly used for infrastructure provisioning.
- Both can be used together in a DevOps workflow.
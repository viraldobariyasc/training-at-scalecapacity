# Ansible Inventory Management Notes

## 1. What is Ansible Inventory?

An **inventory** is a file that tells Ansible which servers it needs to manage.

```text
                Ansible
                   |
               Inventory
                   |
        +----------+----------+
        |          |          |
      web1       web2       db1
```

Inventory can contain:

- Server names
- IP addresses
- Groups
- Connection information
- Host-specific variables

---

## 2. Static Inventory

A simple inventory can be written in INI format.

Example `inventory.ini`:

```ini
[webservers]
web1 ansible_host=10.0.1.10
web2 ansible_host=10.0.1.11

[databases]
db1 ansible_host=10.0.2.10
```

Here:

- `webservers` → Group
- `web1`, `web2` → Hosts
- `ansible_host` → Actual IP address
- `databases` → Another group

### Why Groups?

Groups allow us to target specific types of servers.

For example:

```bash
ansible webservers -m ping -i inventory.ini
```

This targets only the servers inside `webservers`.

---

## 3. Hostnames and IP Addresses

You can use an IP address directly:

```ini
[webservers]
10.0.1.10
10.0.1.11
```

Or use friendly hostnames:

```ini
[webservers]
web1 ansible_host=10.0.1.10
web2 ansible_host=10.0.1.11
```

The second approach is usually easier to understand and maintain.

---

## 4. Host Variables

Variables can be defined for a specific host.

```ini
[webservers]
web1 ansible_host=10.0.1.10 ansible_user=ubuntu
web2 ansible_host=10.0.1.11 ansible_user=ubuntu
```

Here, `ansible_user` tells Ansible which SSH user to use.

---

## 5. Group Variables

If multiple servers have the same configuration, group variables can be used instead of repeating the values.

Example:

```ini
[webservers]
web1 ansible_host=10.0.1.10
web2 ansible_host=10.0.1.11

[webservers:vars]
ansible_user=ubuntu
```

Now both servers use the `ubuntu` user.

---

## 6. Inventory with Playbooks

Inventory groups are commonly referenced through `hosts`.

Inventory:

```ini
[webservers]
web1 ansible_host=10.0.1.10
web2 ansible_host=10.0.1.11
```

Playbook:

```yaml
- name: Configure web servers
  hosts: webservers

  tasks:
    - name: Test connection
      ansible.builtin.ping:
```

Ansible will run the task against all hosts in the `webservers` group.

---

## 7. Important Inventory Commands

### List all inventory hosts

```bash
ansible-inventory -i inventory.ini --list
```

### Display inventory as a graph

```bash
ansible-inventory -i inventory.ini --graph
```

Example:

```text
@all:
  |--@webservers:
  |  |--web1
  |  |--web2
  |--@databases:
     |--db1
```

### Test a group

```bash
ansible webservers -i inventory.ini -m ping
```

Expected:

```text
web1 | SUCCESS => {
    "ping": "pong"
}

web2 | SUCCESS => {
    "ping": "pong"
}
```

---

## 8. Practical

### Objective

Create an inventory containing web and database servers and verify the inventory.

### Step 1: Create Inventory

```bash
mkdir ansible
cd ansible
nano inventory.ini
```

Add:

```ini
[webservers]
web1 ansible_host=10.0.1.10
web2 ansible_host=10.0.1.11

[databases]
db1 ansible_host=10.0.2.10
```

### Step 2: Check Inventory

```bash
ansible-inventory -i inventory.ini --graph
```

### Step 3: Test Web Servers

```bash
ansible webservers -i inventory.ini -m ping
```

### Verification

If the servers are reachable, Ansible should return:

```text
SUCCESS
"ping": "pong"
```

**Screenshot:** Add a screenshot of the inventory file and successful `ansible-inventory --graph` / `ansible ... -m ping` output.

---

## 9. Common Mistakes

### Wrong Group Name

Inventory:

```ini
[webservers]
web1 ansible_host=10.0.1.10
```

Playbook:

```yaml
hosts: webserver
```

This is incorrect because `webserver` and `webservers` are different names.

### Wrong IP Address

Make sure `ansible_host` contains the correct reachable IP address.

### SSH Problems

Even with a correct inventory, connection can fail because of:

- Incorrect username
- Wrong SSH key
- Port 22 blocked
- Server not reachable

---

## 10. Best Practices

- Use meaningful group names such as `webservers`, `databases`, and `loadbalancers`.
- Keep inventory organized by environment when needed.
- Avoid hardcoding secrets in inventory files.
- Use group variables for common configuration.
- Store inventory files in Git when appropriate.
- Verify inventory with `ansible-inventory --graph`.

---

## 11. Interview Questions

1. What is an Ansible inventory?
2. What is the difference between a host and a group?
3. What is `ansible_host`?
4. Why are inventory groups useful?
5. What are host variables?
6. What are group variables?
7. How do you verify an Ansible inventory?
8. What is the difference between static and dynamic inventory?

---

## 12. Summary

- Inventory tells Ansible **which servers to manage**.
- Hosts represent individual machines.
- Groups organize related machines.
- `ansible_host` can define the actual IP address.
- Host variables apply to individual hosts.
- Group variables apply to all hosts in a group.
- `ansible-inventory` helps inspect and verify inventory.
- A well-organized inventory makes Ansible automation easier to manage.
# Ansible Playbooks Notes

## 1. What is an Ansible Playbook?

An **Ansible Playbook** is a YAML file that defines the tasks Ansible should perform on managed servers.

Instead of running commands manually, we write the required configuration once in a playbook and Ansible executes it.

```text
Playbook
   |
   +--> Select hosts
   |
   +--> Run tasks
   |
   +--> Use modules
   |
   v
Managed Servers
```

Example:

```yaml
- name: Configure web server
  hosts: webservers
  become: true

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
```

---

## 2. Playbook Structure

A basic playbook contains:

| Component | Purpose |
|---|---|
| Play | Defines target hosts and overall work |
| `hosts` | Specifies which inventory group to use |
| `become` | Enables privilege escalation |
| `tasks` | List of operations |
| Module | Performs the actual operation |

```text
Play
 |
 +-- hosts
 |
 +-- become
 |
 +-- tasks
       |
       +-- Module
       +-- Module
```

---

## 3. Plays and Tasks

### 3.1 Play

A **play** connects a group of hosts with a set of tasks.

```yaml
- name: Configure web servers
  hosts: webservers
```

### 3.2 Task

A **task** is one specific operation.

```yaml
tasks:
  - name: Install Nginx
    apt:
      name: nginx
      state: present
```

A playbook can contain multiple plays and each play can contain multiple tasks.

---

## 4. Practical Example

### 4.1 Objective

Create a playbook that installs Nginx and ensures that its service is running.

### 4.2 Inventory

Create `inventory.ini`:

```ini
[webservers]
web1 ansible_host=10.0.1.10
```

### 4.3 Playbook

Create `webserver.yml`:

```yaml
- name: Configure web server
  hosts: webservers
  become: true

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: true

    - name: Ensure Nginx is running
      service:
        name: nginx
        state: started
        enabled: true
```

### 4.4 Run the Playbook

```bash
ansible-playbook -i inventory.ini webserver.yml
```

Example output:

```text
PLAY [Configure web server] ************************

TASK [Install Nginx] ********************************
changed: [web1]

TASK [Ensure Nginx is running] ***********************
changed: [web1]

PLAY RECAP *******************************************
web1 : ok=2 changed=2 failed=0
```

### 4.5 Understanding the Output

- `ok` → Task completed and no change was required.
- `changed` → Ansible made a change.
- `failed` → Task failed.

If you run the same playbook again, you may get:

```text
web1 : ok=2 changed=0 failed=0
```

This demonstrates **idempotency**.

---

## 5. Important Commands

Check the playbook syntax:

```bash
ansible-playbook --syntax-check -i inventory.ini webserver.yml
```

Run the playbook:

```bash
ansible-playbook -i inventory.ini webserver.yml
```

Perform a dry run:

```bash
ansible-playbook -i inventory.ini webserver.yml --check
```

Run with more detailed output:

```bash
ansible-playbook -i inventory.ini webserver.yml -v
```

---

## 6. Why Playbooks Are Important

Playbooks provide:

- Repeatable automation
- Consistent server configuration
- Version-controlled infrastructure configuration
- Less manual work
- Easier deployments
- Idempotent operations

Instead of documenting:

```text
1. SSH into server
2. Install Nginx
3. Start Nginx
4. Enable Nginx
```

We can define the desired state in a playbook and run it whenever required.

---

## 7. Common Mistakes

- Incorrect YAML indentation.
- Wrong inventory group name.
- Incorrect module parameters.
- Forgetting `become: true` when root privileges are required.
- Using the wrong SSH credentials.
- Using `command` unnecessarily instead of an appropriate module.

Example of incorrect YAML:

```yaml
tasks:
- name: Install Nginx
    apt:
```

YAML indentation matters.

---

## 8. Best Practices

- Use meaningful names for plays and tasks.
- Keep playbooks simple and focused.
- Use modules instead of unnecessary shell commands.
- Store playbooks in Git.
- Use `--syntax-check` before running.
- Use `--check` when appropriate to preview changes.
- Keep secrets out of playbooks.

---

## 9. Interview Questions

1. What is an Ansible Playbook?
2. What is the difference between a play and a task?
3. What format is used by Ansible Playbooks?
4. How do you execute a playbook?
5. What does `become: true` do?
6. What is idempotency in Ansible?
7. How can you check a playbook before executing it?
8. What is the difference between `ansible` and `ansible-playbook`?

---

## 10. Summary

- A playbook is a YAML file used to define Ansible automation.
- A **play** targets hosts and contains tasks.
- A **task** performs one operation using a module.
- `ansible-playbook` is used to execute playbooks.
- `--check` can be used for a dry run.
- Playbooks should be repeatable and idempotent.
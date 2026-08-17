# Ansible Modules and Plugins Notes

## 1. Modules

### 1.1 What is an Ansible Module?

A **module** is a unit of code that performs a specific task on a managed node.

For example:

```text
Playbook
   |
   v
Module
   |
   +--> Install package
   +--> Create user
   +--> Copy file
   +--> Start service
```

Example:

```yaml
- name: Install Nginx
  ansible.builtin.apt:
    name: nginx
    state: present
```

Here:

- `apt` → Module
- `name` → Module argument
- `nginx` → Package to install
- `state: present` → Desired state

---

## 2. Common Modules

| Module | Purpose |
|---|---|
| `apt` | Manage Debian/Ubuntu packages |
| `dnf` | Manage Fedora/RHEL packages |
| `copy` | Copy files |
| `file` | Manage files/directories |
| `user` | Manage users |
| `service` | Manage services |
| `command` | Execute commands |
| `shell` | Execute shell commands |
| `debug` | Display information |
| `template` | Generate files using Jinja2 |

Example:

```yaml
- name: Create application directory
  ansible.builtin.file:
    path: /opt/myapp
    state: directory
    mode: '0755'
```

---

## 3. Why Use Modules?

Modules provide a structured and usually **idempotent** way to perform operations.

Instead of:

```yaml
- name: Install Nginx
  ansible.builtin.shell: apt install nginx -y
```

Prefer:

```yaml
- name: Install Nginx
  ansible.builtin.apt:
    name: nginx
    state: present
```

The module understands the desired state and can avoid unnecessary changes.

---

## 4. Plugins

### 4.1 What is a Plugin?

An Ansible **plugin extends or modifies how Ansible works**.

Unlike modules, which usually perform tasks on managed nodes, plugins mainly extend Ansible's behavior on the control side.

Common plugin types include:

| Plugin Type | Purpose |
|---|---|
| Connection | Controls how Ansible connects to hosts |
| Inventory | Provides inventory sources |
| Lookup | Retrieves data from external/local sources |
| Callback | Controls Ansible output/events |
| Filter | Modifies data in templates/expressions |
| Become | Provides privilege escalation methods |

Example connection methods:

```text
Ansible
   |
   +--> SSH connection plugin
   |
   +--> Connect to managed server
```

---

## 5. Modules vs Plugins

| Feature | Modules | Plugins |
|---|---|---|
| Main purpose | Perform tasks | Extend Ansible behavior |
| Example | `apt`, `copy`, `user` | SSH, lookup, callback |
| Usually runs | Managed node | Mainly control node |
| Used directly in tasks | Yes | Usually no |

Simple way to remember:

```text
Module  → "Do something"
Plugin  → "Change/extend how Ansible works"
```

---

## 6. Useful Commands

List available modules:

```bash
ansible-doc -l
```

Get documentation for a module:

```bash
ansible-doc ansible.builtin.apt
```

Example:

```bash
ansible-doc ansible.builtin.copy
```

This shows:

- Module description
- Parameters
- Examples
- Return values

---

## 7. Practical

### Objective

Use an Ansible module to create a directory and verify it.

### Step 1: Create a Playbook

Create `module-test.yml`:

```yaml
- name: Test Ansible module
  hosts: webservers
  become: true

  tasks:
    - name: Create application directory
      ansible.builtin.file:
        path: /opt/myapp
        state: directory
        mode: '0755'
```

### Step 2: Run

```bash
ansible-playbook -i inventory.ini module-test.yml
```

### Step 3: Verify

On the managed server:

```bash
ls -ld /opt/myapp
```

Expected:

```text
drwxr-xr-x ... /opt/myapp
```

**Screenshot:** Add a screenshot of the successful playbook execution and directory verification.

---

## 8. Best Practices

- Prefer Ansible modules over `shell` or `command` when a suitable module exists.
- Use fully qualified module names such as:
  `ansible.builtin.copy`
- Check module documentation using `ansible-doc`.
- Understand module parameters before using them.
- Keep automation simple and idempotent.

---

## 9. Common Mistakes

- Using `shell` for tasks that already have a dedicated module.
- Using incorrect module parameters.
- Confusing modules with plugins.
- Not checking module documentation.
- Using a module that is not suitable for the target operating system.

---

## 10. Interview Questions

1. What is an Ansible module?
2. Give some examples of Ansible modules.
3. What is an Ansible plugin?
4. What is the difference between a module and a plugin?
5. Why should modules generally be preferred over shell commands?
6. How can you find documentation for an Ansible module?
7. What is a connection plugin?
8. What is a lookup plugin?

---

## 11. Summary

- **Modules perform tasks** such as installing packages, copying files, and managing services.
- **Plugins extend Ansible's behavior** such as connections, lookups, and output handling.
- Use `ansible-doc` to understand modules and their parameters.
- Prefer dedicated modules over `shell` or `command` when possible.
- Easy way to remember:

```text
Module → Performs the work
Plugin → Extends Ansible
```
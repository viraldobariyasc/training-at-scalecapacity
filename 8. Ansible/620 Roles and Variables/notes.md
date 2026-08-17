# Ansible Roles and Variables Notes

## 1. Variables in Ansible

### 1.1 What are Variables?

Variables allow us to store values that can change between hosts, environments, or deployments.

Instead of writing:

```yaml
name: nginx
```

we can use:

```yaml
name: "{{ package_name }}"
```

and define:

```yaml
package_name: nginx
```

This makes playbooks more reusable.

### 1.2 Example

```yaml
- name: Install package
  hosts: webservers
  become: true

  vars:
    package_name: nginx

  tasks:
    - name: Install package
      ansible.builtin.apt:
        name: "{{ package_name }}"
        state: present
```

Here:

- `package_name` is the variable.
- `{{ package_name }}` retrieves its value.

---

## 2. Common Places for Variables

Variables can be defined in several places:

| Location | Purpose |
|---|---|
| Playbook | Variables specific to a play |
| Inventory | Host/group-specific values |
| `group_vars/` | Variables for a group |
| `host_vars/` | Variables for a host |
| Role `defaults/` | Default role values |
| Role `vars/` | Role-specific variables |

Example:

```text
ansible/
├── inventory.ini
├── playbook.yml
├── group_vars/
│   └── webservers.yml
└── host_vars/
    └── web1.yml
```

---

## 3. Roles

### 3.1 What is a Role?

A **role** is a standard structure for organizing and reusing Ansible automation.

Instead of putting everything into one large playbook, related tasks, variables, templates, and handlers can be organized inside a role.

```text
Playbook
   |
   +--> nginx role
   |      |
   |      +--> Tasks
   |      +--> Variables
   |      +--> Templates
   |      +--> Handlers
   |
   +--> docker role
```

### 3.2 Why Use Roles?

Roles are useful because they:

- Keep automation organized.
- Make code reusable.
- Make large projects easier to maintain.
- Allow the same configuration to be used in multiple playbooks.

---

## 4. Role Structure

A typical role looks like:

```text
roles/
└── nginx/
    ├── tasks/
    │   └── main.yml
    ├── handlers/
    │   └── main.yml
    ├── templates/
    ├── files/
    ├── vars/
    │   └── main.yml
    └── defaults/
        └── main.yml
```

Important directories:

| Directory | Purpose |
|---|---|
| `tasks/` | Main tasks |
| `handlers/` | Handlers triggered by tasks |
| `templates/` | Jinja2 templates |
| `files/` | Static files |
| `defaults/` | Default variables |
| `vars/` | Role variables |

---

## 5. Practical Example

### 5.1 Objective

Create a reusable role that installs Nginx.

### Step 1: Create the Role

```bash
ansible-galaxy role init nginx
```

This creates the role structure.

### Step 2: Add Task

Edit:

```text
roles/nginx/tasks/main.yml
```

```yaml
---
- name: Install Nginx
  ansible.builtin.apt:
    name: "{{ nginx_package }}"
    state: present
    update_cache: true

- name: Start Nginx
  ansible.builtin.service:
    name: "{{ nginx_package }}"
    state: started
    enabled: true
```

### Step 3: Add Default Variable

Edit:

```text
roles/nginx/defaults/main.yml
```

```yaml
---
nginx_package: nginx
```

### Step 4: Use the Role

Create `site.yml`:

```yaml
---
- name: Configure web server
  hosts: webservers
  become: true

  roles:
    - nginx
```

Run:

```bash
ansible-playbook -i inventory.ini site.yml
```

The playbook now uses the reusable `nginx` role.

---

## 6. `defaults` vs `vars`

This is an important interview topic.

### `defaults/main.yml`

Contains default values that can easily be overridden.

```yaml
nginx_package: nginx
```

### `vars/main.yml`

Contains role variables that generally have higher precedence and are harder to override.

For reusable roles, **`defaults` is commonly preferred for configurable values**.

---

## 7. Variable Precedence

Ansible can receive the same variable from multiple places.

For example:

```text
Role defaults
     ↓
Inventory variables
     ↓
Playbook variables
     ↓
Extra variables
```

Generally, variables defined with higher precedence override lower-precedence values.

For example:

```bash
ansible-playbook site.yml -e "nginx_package=apache2"
```

The `-e` / `--extra-vars` value has very high precedence.

You don't need to memorize every precedence level initially. The important idea is:

**When the same variable is defined multiple times, Ansible follows its variable precedence rules to decide which value wins.**

---

## 8. Best Practices

- Use meaningful variable names.
- Keep reusable/default values in `defaults/main.yml`.
- Avoid hardcoding values inside tasks.
- Use roles for reusable automation.
- Keep roles focused on one purpose.
- Do not store passwords directly in variables.
- Use Ansible Vault or a secret manager for sensitive values.

---

## 9. Common Mistakes

- Incorrect variable name.
- Incorrect Jinja syntax.

Correct:

```yaml
name: "{{ nginx_package }}"
```

Incorrect:

```yaml
name: "{ nginx_package }"
```

- Putting configurable values directly into tasks.
- Creating very large roles that perform unrelated operations.

---

## 10. Interview Questions

1. What is an Ansible variable?
2. Why are variables useful?
3. What is an Ansible role?
4. Why are roles used?
5. What is the difference between `defaults` and `vars`?
6. What is variable precedence?
7. How do you pass an extra variable while running a playbook?
8. What is the purpose of `tasks/main.yml` in a role?

---

## 11. Summary

- **Variables** make Ansible automation dynamic and reusable.
- `{{ variable_name }}` is used to reference a variable.
- **Roles** organize related automation into a reusable structure.
- `tasks/` contains role tasks.
- `defaults/` contains easily overridable default values.
- `vars/` contains role variables with higher precedence.
- Roles and variables make large Ansible projects easier to maintain.
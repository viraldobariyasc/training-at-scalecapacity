# Ansible Handlers and Conditions Notes

## 1. Handlers

### 1.1 What is a Handler?

A **handler** is a special task that runs only when another task reports a **change** and notifies it.

Handlers are commonly used for actions such as:

- Restarting a service
- Reloading a configuration
- Restarting an application

Example:

```yaml
tasks:
  - name: Update Nginx configuration
    ansible.builtin.copy:
      src: nginx.conf
      dest: /etc/nginx/nginx.conf
    notify: Restart Nginx

handlers:
  - name: Restart Nginx
    ansible.builtin.service:
      name: nginx
      state: restarted
```

### 1.2 How It Works

```text
Task
 |
 | Configuration changed?
 |
 +---- No ----> Handler does not run
 |
 +---- Yes ---> notify
                 |
                 v
            Handler runs
```

The main benefit is that we don't restart a service unnecessarily.

---

## 2. `notify`

`notify` connects a task to a handler.

```yaml
notify: Restart Nginx
```

The handler name must match:

```yaml
handlers:
  - name: Restart Nginx
```

Handlers normally run after the relevant tasks have completed.

---

## 3. Conditions

Ansible conditions allow a task to run **only when a specific condition is true**.

The most commonly used condition is `when`.

Example:

```yaml
- name: Install Nginx on Ubuntu
  ansible.builtin.apt:
    name: nginx
    state: present
  when: ansible_facts['os_family'] == "Debian"
```

The task runs only when the condition is true.

```text
Condition
    |
 +-- True  ---> Run task
 |
 +-- False ---> Skip task
```

---

## 4. Practical Example

### Objective

Install Nginx only on Debian-based systems and restart it only when its configuration changes.

```yaml
- name: Configure web server
  hosts: webservers
  become: true

  tasks:
    - name: Install Nginx
      ansible.builtin.apt:
        name: nginx
        state: present
      when: ansible_facts['os_family'] == "Debian"

    - name: Copy Nginx configuration
      ansible.builtin.copy:
        src: nginx.conf
        dest: /etc/nginx/nginx.conf
      notify: Restart Nginx

  handlers:
    - name: Restart Nginx
      ansible.builtin.service:
        name: nginx
        state: restarted
```

### Expected Behavior

If the configuration file changes:

```text
Copy configuration
       |
    Changed
       |
    notify
       |
Restart Nginx
```

If the configuration is already the same:

```text
Copy configuration
       |
    Unchanged
       |
Handler does not run
```

---

## 5. Useful Conditions

### Multiple Conditions

```yaml
when:
  - ansible_facts['os_family'] == "Debian"
  - ansible_facts['distribution_major_version'] == "24"
```

Both conditions must be true.

### Check a Variable

```yaml
when: install_nginx
```

Example:

```yaml
vars:
  install_nginx: true
```

### `failed_when`

Used when you want to define when a task should be considered failed.

```yaml
- name: Check application
  ansible.builtin.command: /opt/app/check.sh
  register: result
  failed_when: result.rc != 0
```

### `changed_when`

Used to control whether Ansible considers a task changed.

```yaml
- name: Run health check
  ansible.builtin.command: /opt/app/health-check.sh
  changed_when: false
```

This is useful for commands that only check something and should not report a configuration change.

---

## 6. Best Practices

- Use handlers for service restarts/reloads.
- Don't restart services after every task unnecessarily.
- Keep `when` conditions simple and readable.
- Use facts when conditions depend on the operating system.
- Use `changed_when` and `failed_when` carefully.
- Give handlers descriptive names.

---

## 7. Common Mistakes

### Handler Name Mismatch

```yaml
notify: Restart Nginx
```

must match:

```yaml
- name: Restart Nginx
```

### Incorrect Condition Syntax

Use:

```yaml
when: ansible_facts['os_family'] == "Debian"
```

Do not unnecessarily wrap the expression in `{{ }}`.

### Expecting Handlers to Run Immediately

Handlers are normally executed after the relevant tasks have completed, not immediately when `notify` is encountered.

---

## 8. Interview Questions

1. What is an Ansible handler?
2. Why are handlers used?
3. What is the purpose of `notify`?
4. When does a handler execute?
5. What is the `when` condition?
6. What is `failed_when`?
7. What is `changed_when`?
8. Why shouldn't services be restarted unnecessarily?

---

## 9. Summary

- **Handlers** perform actions when notified by changed tasks.
- `notify` connects a task to a handler.
- **`when`** controls whether a task should run.
- **`failed_when`** controls when a task is considered failed.
- **`changed_when`** controls whether a task is considered changed.
- Handlers are especially useful for restarting or reloading services only when configuration actually changes.
# Ansible Vault Notes

## 1. What is Ansible Vault?

**Ansible Vault** is used to securely encrypt sensitive data used by Ansible.

Examples of sensitive data:

- Passwords
- API keys
- Database credentials
- SSH-related secrets
- Cloud credentials

Instead of storing:

```yaml
db_password: MySecretPassword
```

in plain text, we can encrypt the file using Ansible Vault.

```text
Plaintext Secrets
       |
       v
 Ansible Vault
       |
       v
 Encrypted File
```

---

## 2. Why Use Ansible Vault?

Without Vault:

```text
Git Repository
     |
     +--> passwords.yml
     +--> API keys
```

Anyone with repository access may see the secrets.

With Vault:

```text
Git Repository
     |
     +--> secrets.yml (encrypted)
                    |
                 Vault Password
                    |
                    v
              Ansible uses secret
```

This allows encrypted secret files to be stored safely in version control.

---

## 3. Create an Encrypted File

Create a new encrypted file:

```bash
ansible-vault create secrets.yml
```

Ansible asks for a Vault password.

Then add:

```yaml
db_username: admin
db_password: SuperSecret123
```

The file will be stored in encrypted form.

---

## 4. View an Encrypted File

```bash
ansible-vault view secrets.yml
```

Enter the Vault password to view the decrypted content.

---

## 5. Edit an Encrypted File

```bash
ansible-vault edit secrets.yml
```

This allows you to modify the encrypted file without manually decrypting it.

---

## 6. Encrypt an Existing File

If you already have a plaintext file:

```bash
ansible-vault encrypt secrets.yml
```

The file becomes encrypted.

---

## 7. Decrypt a File

```bash
ansible-vault decrypt secrets.yml
```

This converts it back to plaintext.

Use this carefully because the secrets will no longer be encrypted.

---

## 8. Using Vault with a Playbook

Suppose `secrets.yml` contains:

```yaml
db_username: admin
db_password: SuperSecret123
```

Playbook:

```yaml
- name: Use encrypted variables
  hosts: webservers

  vars_files:
    - secrets.yml

  tasks:
    - name: Display username
      ansible.builtin.debug:
        var: db_username
```

Run:

```bash
ansible-playbook -i inventory.ini site.yml --ask-vault-pass
```

Ansible asks for the Vault password and decrypts the required data during execution.

---

## 9. Practical

### Objective

Create an encrypted variables file and use it from a playbook.

### Step 1: Create Vault File

```bash
ansible-vault create secrets.yml
```

Add:

```yaml
app_username: admin
app_password: Secret123
```

### Step 2: Create Playbook

```yaml
- name: Test Ansible Vault
  hosts: localhost
  connection: local

  vars_files:
    - secrets.yml

  tasks:
    - name: Display username
      ansible.builtin.debug:
        var: app_username
```

### Step 3: Run

```bash
ansible-playbook site.yml --ask-vault-pass
```

### Expected Output

```text
TASK [Display username]
ok: [localhost] => {
    "app_username": "admin"
}
```

**Important:** Avoid displaying actual passwords with `debug`.

**Screenshot:** Add a screenshot of the encrypted `secrets.yml` and successful playbook execution.

---

## 10. Best Practices

- Never commit plaintext secrets to Git.
- Use Ansible Vault for secrets that must be stored with Ansible code.
- Use `no_log: true` for tasks that may expose sensitive information.
- Keep the Vault password secure.
- Do not store the Vault password directly inside the repository.
- For production environments, consider using dedicated secret managers such as AWS Secrets Manager or HashiCorp Vault when appropriate.

---

## 11. Common Commands

| Command | Purpose |
|---|---|
| `ansible-vault create` | Create encrypted file |
| `ansible-vault view` | View encrypted file |
| `ansible-vault edit` | Edit encrypted file |
| `ansible-vault encrypt` | Encrypt existing file |
| `ansible-vault decrypt` | Decrypt file |
| `ansible-vault rekey` | Change Vault password |

---

## 12. Interview Questions

1. What is Ansible Vault?
2. Why is Ansible Vault used?
3. How do you encrypt an existing file?
4. How do you use a Vault file in a playbook?
5. What is `--ask-vault-pass`?
6. Should Vault passwords be stored in Git?
7. What is the difference between Ansible Vault and a secret manager?

---

## 13. Summary

- Ansible Vault protects sensitive Ansible data through encryption.
- It is useful for passwords, API keys, and other secrets.
- Use `ansible-vault create` to create encrypted files.
- Use `--ask-vault-pass` when running playbooks that require the Vault password.
- Never commit plaintext secrets to Git.
- For larger production environments, dedicated secret-management services may be more suitable.
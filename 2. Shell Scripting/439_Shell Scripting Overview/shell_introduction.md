# 1. Shell Introduction

## 1.1 What is Shell?

A **Shell** is a command-line interpreter that acts as an interface between the user and the operating system. It receives commands from the user, interprets them, and asks the operating system (kernel) to execute them.

### Working of Shell

```text
User
   │
   │ Command
   ▼
Shell
   │
   │ System Call
   ▼
Linux Kernel
   │
   ▼
Hardware
```

For example, when we execute:

```bash
ls
```

The Shell interprets the command, requests the Linux kernel to list the files in the current directory, and displays the result.

### Why do we need a Shell?

- Execute Linux commands.
- Manage files and directories.
- Install and manage software.
- Automate repetitive tasks.
- Configure servers.
- Perform system administration.
- Execute scripts.

Shell is one of the most important tools in Linux and DevOps because almost every server administration task is performed through it.

---

# 1.2 What is Shell Scripting?

A **Shell Script** is a text file containing a sequence of shell commands that are executed automatically.

Instead of executing commands one by one, we can write them into a script and run the script whenever required.

Example:

```bash
#!/bin/bash

echo "Hello World"
echo "Welcome to Shell Scripting"
```

Save the file as:

```text
hello.sh
```

Make it executable:

```bash
chmod +x hello.sh
```

Run it:

```bash
./hello.sh
```

Output:

```text
Hello World
Welcome to Shell Scripting
```

### Advantages of Shell Scripting

- Automates repetitive tasks.
- Saves time.
- Reduces manual errors.
- Easy to maintain.
- Useful for backups, deployments, monitoring and automation.
- Widely used in DevOps and CI/CD pipelines.

---

# 1.3 Types of Shell

Linux provides multiple shell programs.

## 1. Bourne Shell (sh)

- Developed by Stephen Bourne.
- Original Unix shell.
- Lightweight and portable.
- Basic scripting capabilities.

Command:

```bash
sh
```

---

## 2. Bourne Again Shell (bash)

- Improved version of Bourne Shell.
- Default shell in most Linux distributions.
- Supports variables, loops, functions and conditions.
- Most commonly used shell for scripting.

Command:

```bash
bash
```

---

## 3. C Shell (csh)

- Syntax similar to the C programming language.
- Mostly used by programmers familiar with C.

Command:

```bash
csh
```

---

## 4. Korn Shell (ksh)

- Combines features of Bourne Shell and C Shell.
- Supports advanced scripting.

Command:

```bash
ksh
```

---

## 5. Z Shell (zsh)

- Extension of Bash.
- Better auto-completion.
- Command suggestions.
- Highly customizable.

Command:

```bash
zsh
```

---

## Comparison

| Shell | Description |
|--------|-------------|
| sh | Original Unix shell |
| bash | Most widely used shell |
| csh | C language style shell |
| ksh | Advanced Unix shell |
| zsh | Modern shell with additional features |

---

# 1.4 Setting up Ubuntu using WSL

## What is WSL?

**WSL (Windows Subsystem for Linux)** allows users to run a Linux environment directly on Windows without using a virtual machine or dual boot.

Architecture:

```text
Windows
    │
    ▼
WSL
    │
    ▼
Ubuntu
    │
    ▼
Bash Shell
```

### Why use WSL?

- Learn Linux without installing a separate operating system.
- Practice shell scripting.
- Run Linux tools on Windows.
- Useful for software development and DevOps.

### Installation Steps

Enable WSL:

```powershell
wsl --install
```

Install Ubuntu:

```powershell
wsl --install -d Ubuntu
```

Check installed distributions:

```powershell
wsl --list
```

Launch Ubuntu:

```powershell
wsl
```

Verify the installation:

```bash
whoami
```

```bash
pwd
```

```bash
ls
```

Update packages:

```bash
sudo apt update
sudo apt upgrade
```

---

# 1.5 Extra Topics

## Difference between Terminal, Console and Shell

| Terminal | Console | Shell |
|----------|----------|--------|
| Application used to interact with the system | Physical or virtual device used for system access | Program that interprets and executes commands |

The **Terminal** provides the interface, while the **Shell** runs inside the Terminal and executes commands.

---

## Shell vs Bash

| Shell | Bash |
|--------|------|
| General term for any command interpreter | A specific implementation of a shell |
| Includes sh, bash, zsh, ksh, etc. | Most commonly used shell in Linux |

All Bash programs are Shell programs, but not all Shell programs are Bash.

---

## Importance of Shell Scripting in DevOps

Shell scripting is extensively used for:

- Deployment automation
- Server configuration
- Backup automation
- Log monitoring
- Application startup scripts
- CI/CD pipelines
- Docker and Kubernetes automation
- Cron jobs

Example:

```bash
#!/bin/bash

echo "Starting Deployment..."

docker build -t myapp .
docker run -d myapp

echo "Deployment Completed."
```

---

# 1.6 Summary

- Shell is an interface between the user and the operating system.
- Shell scripting automates Linux commands.
- Bash is the most commonly used shell in Linux.
- WSL allows Linux to run on Windows.
- Shell scripting is an essential skill for Linux administration and DevOps.
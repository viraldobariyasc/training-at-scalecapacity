# 1. Linux Commands, Permissions and Variables

---

# 1.1 Important Linux Commands

Linux provides many built-in commands for managing files, directories, users, and the operating system.

## Navigation Commands

### Print Current Directory

```bash
pwd
```

Displays the current working directory.

Example:

```text
/home/viral/projects
```

---

### List Files

```bash
ls
```

Useful options:

```bash
ls -l
```

Long listing format.

```bash
ls -a
```

Shows hidden files.

```bash
ls -lh
```

Human-readable file sizes.

---

### Change Directory

```bash
cd Documents
```

Go back one directory:

```bash
cd ..
```

Go to home directory:

```bash
cd
```

Go to previous directory:

```bash
cd -
```

---

# File Operations

### Create File

```bash
touch notes.txt
```

---

### Create Directory

```bash
mkdir projects
```

Create nested directories:

```bash
mkdir -p java/spring/api
```

---

### Copy Files

```bash
cp file.txt backup.txt
```

Copy directory recursively:

```bash
cp -r project backup
```

---

### Move or Rename

Move:

```bash
mv file.txt Documents/
```

Rename:

```bash
mv old.txt new.txt
```

---

### Delete File

```bash
rm file.txt
```

Delete directory recursively:

```bash
rm -r project
```

Force delete:

```bash
rm -rf project
```

⚠ Use `rm -rf` carefully because deleted files cannot be recovered easily.

---

# View File Contents

Display file:

```bash
cat file.txt
```

View page by page:

```bash
less file.txt
```

First 10 lines:

```bash
head file.txt
```

Last 10 lines:

```bash
tail file.txt
```

Monitor logs continuously:

```bash
tail -f application.log
```

---

# Search Commands

Find files:

```bash
find . -name "*.java"
```

Search inside files:

```bash
grep "ERROR" app.log
```

Recursive search:

```bash
grep -R "SpringBoot" .
```

---

# System Information

Current user:

```bash
whoami
```

Current date:

```bash
date
```

Disk usage:

```bash
df -h
```

Memory usage:

```bash
free -h
```

Running processes:

```bash
ps
```

Real-time processes:

```bash
top
```

---

# 1.2 Changing Ownership and Permissions

Every file and directory in Linux has:

- Owner
- Group
- Permissions

View permissions:

```bash
ls -l
```

Example:

```text
-rwxr-xr--
```

Breakdown:

```text
Owner   Group   Others
rwx      r-x      r--
```

Meaning:

- r = Read
- w = Write
- x = Execute

---

## chmod

Changes file permissions.

Example:

```bash
chmod +x script.sh
```

Adds execute permission.

Numeric permissions:

```bash
chmod 755 script.sh
```

Meaning:

```
7 = rwx
5 = r-x
5 = r-x
```

Common values:

| Permission | Meaning |
|------------|---------|
| 777 | Everyone has full access |
| 755 | Owner full access, others read & execute |
| 700 | Only owner has access |
| 644 | Owner read/write, others read only |

---

## chown

Changes file owner.

Example:

```bash
sudo chown viral file.txt
```

Owner and group:

```bash
sudo chown viral:developers file.txt
```

Recursive ownership:

```bash
sudo chown -R viral project/
```

---

## chgrp

Changes group ownership.

```bash
sudo chgrp developers file.txt
```

---

# 1.3 Declaring Variables in Shell

Variables store data.

Syntax:

```bash
name="Viral"
```

Display variable:

```bash
echo $name
```

Output:

```text
Viral
```

---

## Rules

Correct:

```bash
city="Junagadh"
```

Incorrect:

```bash
city = "Junagadh"
```

Spaces are not allowed around `=`.

---

## Numeric Variables

```bash
age=21
```

Display:

```bash
echo $age
```

---

## Read User Input

```bash
read name

echo $name
```

Better:

```bash
read -p "Enter your name: " name

echo "Hello $name"
```

---

## Environment Variables

Display PATH:

```bash
echo $PATH
```

Display HOME:

```bash
echo $HOME
```

Display current user:

```bash
echo $USER
```

Create environment variable:

```bash
export PROJECT_NAME=HotelOS
```

---

# 1.4 Recursion in Commands

Recursion means applying a command to a directory **and all of its subdirectories and files**.

Example directory:

```text
project
├── src
│   ├── Main.java
│   └── Test.java
├── docs
└── images
```

---

## Recursive Copy

```bash
cp -r project backup
```

Entire directory is copied.

---

## Recursive Delete

```bash
rm -r project
```

Deletes directory and everything inside it.

---

## Recursive Ownership

```bash
chown -R viral project
```

Owner changes for every file.

---

## Recursive Permission

```bash
chmod -R 755 project
```

Permissions change for all files and folders.

---

## Recursive Search

```bash
grep -R "Spring" .
```

Searches all files inside the current directory.

---

## Recursive Find

```bash
find . -name "*.sh"
```

Finds every shell script recursively.

---

# 1.5 Extra Topics

## Absolute vs Relative Path

Absolute path starts from the root directory.

Example:

```text
/home/viral/projects/demo
```

Relative path starts from the current directory.

Example:

```text
projects/demo
```

---

## File Permission Representation

Permission symbols:

```text
r = Read
w = Write
x = Execute
```

Numeric representation:

| Number | Permission |
|--------|------------|
| 7 | rwx |
| 6 | rw- |
| 5 | r-x |
| 4 | r-- |

---

## Environment Variables

Environment variables are global variables available to the shell.

Examples:

```bash
echo $HOME
echo $PATH
echo $USER
```

They are commonly used by applications and shell scripts.

---

## Recursive Options

Many Linux commands support recursive execution using:

```bash
-r
```

or

```bash
-R
```

Examples:

```bash
cp -r
rm -r
chmod -R
chown -R
grep -R
```

---

# 1.6 Summary

- Linux commands are used for navigation, file management, searching, and system administration.
- File permissions control who can read, write, or execute files.
- `chmod` changes permissions, while `chown` changes ownership.
- Variables store values and make shell scripts dynamic.
- Recursive commands apply operations to directories and all their contents.
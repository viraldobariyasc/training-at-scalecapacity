# Track a Sample File using Git and Integrate it with Azure Repos

## Objective

To understand how to track a file using Git and integrate a local Git repository with Azure Repos.

---

## Prerequisites

- Git installed on the system
- Azure DevOps account
- Azure Repos repository

---

## Steps Performed

### 1. Initialize Git Repository

Created a project directory and initialized Git.

```bash
mkdir git-sample
cd git-sample
git init
```

---

### 2. Create a Sample File

Created a sample file to track using Git.

```bash
echo "Hello Azure Repos" > sample.txt
```

---

### 3. Check Repository Status

Checked the status of the repository.

```bash
git status
```

The file appeared as an untracked file.

---

### 4. Track the File using Git

Added the file to the staging area.

```bash
git add sample.txt
```

Verified the file status:

```bash
git status
```

The file is now tracked and staged for commit.

---

### 5. Commit the Changes

Created a commit with a meaningful message.

```bash
git commit -m "Add sample file"
```

---

### 6. Create Repository in Azure Repos

Created a new Git repository in Azure DevOps.

---

### 7. Connect Local Repository with Azure Repos

Added Azure Repos as the remote repository.

```bash
git remote add origin <repository-url>
```

Verified remote connection:

```bash
git remote -v
```

---

### 8. Push Changes to Azure Repos

Pushed the local commits to Azure Repos.

```bash
git push -u origin main
```

---

### 9. Verify Repository in Azure Repos

Verified that:
- Sample file is available in Azure Repos.
- Commit history is visible.
- Local changes are successfully pushed.

---

# Result

Successfully tracked a sample file using Git and integrated the local Git repository with Azure Repos.

---

# Learnings

- Learned how to initialize a Git repository.
- Learned how to track files using Git.
- Learned staging and committing changes.
- Learned how to connect Git with Azure Repos.
- Learned how to push local commits to a remote repository.
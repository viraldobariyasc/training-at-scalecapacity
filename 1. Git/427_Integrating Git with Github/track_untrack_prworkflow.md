# Git File Tracking, Forking and Pull Requests

## 1. Tracking a File Using Git

Git tracks changes only for files that have been added to its index (staging area).

### Step 1: Check Repository Status

```bash
git status
```

New files appear as **Untracked Files**.

### Step 2: Start Tracking a File

```bash
git add file.txt
```

or

```bash
git add .
```

After running `git add`, Git starts tracking the file and stages it for the next commit.

### Step 3: Commit the Changes

```bash
git commit -m "Add file.txt"
```

The file is now permanently tracked by Git.

---

## 2. Forking a Repository

A **Fork** creates your own copy of someone else's repository under your GitHub account.

Unlike cloning, a fork exists on GitHub and allows you to make changes without affecting the original project.

### Why is Forking Needed?

* Contribute to open-source projects.
* Experiment without modifying the original repository.
* Maintain your own version of a project.
* Submit improvements back to the original repository using Pull Requests.

Typical workflow:

1. Fork the repository.
2. Clone your fork locally.
3. Create a new branch.
4. Make changes.
5. Commit and push changes.
6. Create a Pull Request.

---

## 3. Creating a Pull Request (PR)

A Pull Request is a request to merge changes from one branch (or fork) into another repository.

### Steps

1. Push your changes to GitHub.

```bash
git push origin feature-branch
```

2. Open the repository on GitHub.

3. Click **Compare & Pull Request**.

4. Add:

   * Title
   * Description
   * Summary of changes

5. Submit the Pull Request.

The repository maintainers review the changes and either approve, request modifications, or reject the PR.

---

# Extra Topics

## Git Tracking vs Untracking

### Tracked Files

* Git monitors all modifications.
* Included in commits.

### Untracked Files

* Git knows the file exists but does not track changes.
* Becomes tracked after `git add`.

---

## Fork vs Clone

| Fork                                           | Clone                                    |
| ---------------------------------------------- | ---------------------------------------- |
| Creates a copy on GitHub                       | Creates a local copy on your computer    |
| Used for contributing to external repositories | Used for working on a repository locally |
| Requires a GitHub account                      | Works with any Git repository            |

---

## Pull Request Best Practices

* Create a separate branch for each feature.
* Keep PRs focused on one change.
* Write clear titles and descriptions.
* Test your code before creating the PR.
* Respond to review comments promptly.

---

## Syncing a Fork with the Original Repository

As the original repository changes, your fork can become outdated.

Steps to keep it updated:

```bash
git remote add upstream <original-repository-url>
git fetch upstream
git merge upstream/main
git push origin main
```

This keeps your fork synchronized with the latest changes from the original repository.

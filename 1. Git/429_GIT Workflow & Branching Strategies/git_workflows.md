# Git Workflows

## 1. Git Workflow

A Git workflow defines the process developers follow to write, review, and integrate code using Git.

A typical workflow is:

1. Clone the repository.
2. Create a new branch.
3. Make changes.
4. Stage the changes.
5. Commit the changes.
6. Push the branch to the remote repository.
7. Create a Pull Request.
8. Review and merge the code.

Common commands:

```bash id="xq7b6r"
git clone <repository-url>
git switch -c feature-login
git add .
git commit -m "Add login feature"
git push origin feature-login
```

---

## 2. Feature Branch Workflow

In this workflow, every new feature or bug fix is developed in its own branch instead of directly on the `main` branch.

Workflow:

1. Create a feature branch.
2. Develop the feature.
3. Commit changes.
4. Push the branch.
5. Create a Pull Request.
6. Review and merge into `main`.

Benefits:

* Keeps the `main` branch stable.
* Enables parallel development.
* Simplifies code reviews.
* Reduces the risk of breaking production code.

---

## 3. Centralized Workflow

In a centralized workflow, all developers work with a single shared repository.

Developers:

* Pull the latest changes.
* Make changes locally.
* Commit changes.
* Push directly to the shared branch (or through PRs, depending on team rules).

Benefits:

* Simple to understand.
* Suitable for small teams.
* Easy repository management.

Limitations:

* Higher chance of merge conflicts.
* Less suitable for large teams.

---

## 4. Merge vs Rebase

### Merge

* Combines branches by creating a merge commit.
* Preserves the complete history of both branches.
* Preferred for collaborative development.

Example:

```bash id="d8z2xh"
git switch main
git merge feature-login
```

### Rebase

* Moves commits from one branch onto another.
* Produces a clean, linear commit history.
* Avoid rebasing commits that have already been pushed to a shared repository.

Example:

```bash id="eujy5d"
git switch feature-login
git rebase main
```

| Merge                     | Rebase                          |
| ------------------------- | ------------------------------- |
| Creates a merge commit    | No merge commit                 |
| Preserves branch history  | Creates a linear history        |
| Safer for shared branches | Best for local/private branches |

---

## 5. Forking Workflow

A Forking Workflow is commonly used in open-source projects.

Instead of directly accessing the main repository, developers:

1. Fork the repository to their own GitHub account.
2. Clone the fork locally.
3. Create a feature branch.
4. Make changes.
5. Commit and push changes.
6. Create a Pull Request to the original repository.

Benefits:

* Developers do not need write access to the original repository.
* Safer for open-source collaboration.
* Maintainers review contributions before merging.

---

# Extra Topics

## GitFlow Workflow

GitFlow is a structured branching model that uses dedicated branches such as:

* `main`
* `develop`
* `feature/*`
* `release/*`
* `hotfix/*`

It is suitable for projects with scheduled releases and multiple development stages.

---

## Trunk-Based Development

In Trunk-Based Development, developers frequently merge small changes into a single main branch (trunk).

Benefits:

* Short-lived branches.
* Fewer merge conflicts.
* Faster integration and deployment.
* Common in modern CI/CD environments.

---

## Choosing the Right Git Workflow

* **Centralized Workflow** – Small teams.
* **Feature Branch Workflow** – Most software development teams.
* **Forking Workflow** – Open-source projects.
* **GitFlow** – Large projects with release cycles.
* **Trunk-Based Development** – CI/CD and continuous deployment.

---

## Best Practices for Team Collaboration

* Create a separate branch for each feature or bug fix.
* Write meaningful commit messages.
* Pull the latest changes before starting work.
* Keep Pull Requests small and focused.
* Review code before merging.
* Resolve merge conflicts promptly.
* Protect the `main` branch from direct commits.

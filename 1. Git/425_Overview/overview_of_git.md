## What is Git?

**Git** is a **distributed version control system (DVCS)** created by **Linus Torvalds** in **2005**. It is used to track changes in files, manage different versions of a project, and enable multiple developers to collaborate efficiently.

Unlike centralized version control systems, every developer has a complete copy of the project's history on their local machine, allowing them to work even without an internet connection.

---

## Key Features of Git

* **Version Control** – Keeps track of every change made to files.
* **Distributed** – Every developer has a complete local copy of the repository.
* **Branching and Merging** – Create separate branches for new features and merge them later.
* **Fast Performance** – Designed for speed, even with large projects.
* **Data Integrity** – Every commit is identified by a unique SHA hash, ensuring history cannot be accidentally altered.
* **Collaboration** – Multiple developers can work on the same project simultaneously.
* **Open Source** – Free to use and supported by a large community.

---

## Why Git is Used

Git helps developers:

* Track changes in source code.
* Restore previous versions if something goes wrong.
* Work on multiple features simultaneously using branches.
* Collaborate with teams without overwriting each other's work.
* Maintain a complete history of the project.

---

## How Git Works

A typical Git workflow is:

```text
Working Directory
        │
     git add
        ▼
 Staging Area
        │
   git commit
        ▼
 Local Repository
        │
   git push
        ▼
 Remote Repository (e.g., GitHub)
```

* **Working Directory**: Where you edit your project files.
* **Staging Area**: Holds changes you want to include in the next commit.
* **Local Repository**: Stores the project's complete history on your computer.
* **Remote Repository**: A shared repository hosted on platforms like GitHub, GitLab, or Bitbucket.

---

## Basic Git Concepts

* **Repository (Repo):** A Git-managed project.
* **Commit:** A snapshot of the project at a specific point in time.
* **Branch:** An independent line of development.
* **Merge:** Combines changes from one branch into another.
* **Clone:** Creates a local copy of a remote repository.
* **Push:** Uploads local commits to a remote repository.
* **Pull:** Downloads and integrates changes from a remote repository.

---

## Advantages of Git

* Complete change history
* Easy collaboration
* Offline development
* Fast branching and merging
* Easy rollback to previous versions
* Supports CI/CD pipelines
* Works well for both small and large projects

---

## Common Git Commands

| Command                       | Purpose                        |
| ----------------------------- | ------------------------------ |
| `git init`                    | Initialize a new repository    |
| `git clone`                   | Copy an existing repository    |
| `git status`                  | Check repository status        |
| `git add`                     | Stage changes                  |
| `git commit`                  | Save a snapshot of changes     |
| `git log`                     | View commit history            |
| `git branch`                  | Manage branches                |
| `git checkout` / `git switch` | Switch branches                |
| `git merge`                   | Merge branches                 |
| `git pull`                    | Fetch and merge remote changes |
| `git push`                    | Upload local commits           |

---

## Real-World Example

Imagine four developers are building an online shopping application:

* Developer A works on user authentication.
* Developer B develops the shopping cart.
* Developer C designs the product catalog.
* Developer D fixes bugs.

Each developer creates a separate branch, commits their changes locally, and pushes them to a shared remote repository. After code review and testing, the branches are merged into the `main` branch. Git keeps track of every change, making collaboration organized and reliable.

---

## Summary

Git is a distributed version control system that helps developers:

* Track and manage code changes.
* Collaborate efficiently with teams.
* Maintain a complete project history.
* Safely experiment using branches.
* Recover from mistakes by reverting to earlier versions.

It is one of the most essential tools in modern software development and is widely used in conjunction with platforms like GitHub, GitLab, and Bitbucket.

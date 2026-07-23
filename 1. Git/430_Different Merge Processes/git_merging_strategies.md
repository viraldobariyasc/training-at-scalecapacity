# Git Merge Strategies

## 1. Fast Forward Merge

A **Fast Forward Merge** occurs when the target branch has **not changed** since the feature branch was created. Git simply moves the branch pointer forward without creating a new merge commit.

### Example

Before merge:

```text id="5i6v2s"
main
A ── B
      \
feature C ── D
```

Merge:

```bash id="x4k2nr"
git switch main
git merge feature
```

After merge:

```text id="v3u1pk"
main
A ── B ── C ── D
```

### Characteristics

* No merge commit is created.
* Produces a clean, linear commit history.
* Works only when `main` has no new commits after the feature branch was created.

### Advantages

* Simple and clean history.
* Easy to understand.
* No unnecessary merge commits.

### Limitations

* Cannot be performed if both branches have diverged.

---

## 2. Squash Merge

A **Squash Merge** combines all commits from a feature branch into **one single commit** before merging into the target branch.

Suppose the feature branch contains:

```text id="ll40gv"
feature

A
│
├── Login UI
├── Validation
├── Bug Fix
└── Styling
```

Instead of preserving all four commits, Git creates one commit.

Merge command:

```bash id="xrgp0y"
git switch main
git merge --squash feature
git commit -m "Add login feature"
```

After merge:

```text id="3zhok7"
main

A ───────── Login Feature
```

The original feature branch history remains, but the `main` branch receives only one commit.

### Characteristics

* Creates a single commit.
* Produces a cleaner project history.
* The individual commits are not added to the target branch.

### Advantages

* Keeps commit history concise.
* Ideal when a feature has many small or temporary commits.
* Makes reviewing project history easier.

### Limitations

* Individual commit history is lost on the target branch.
* Harder to trace the development process of a feature.

---

# Extra Topics

## Three-Way Merge

A **Three-Way Merge** is used when both branches have new commits.

Git compares:

* The common ancestor.
* The target branch.
* The feature branch.

It then creates a **merge commit** that combines both histories.

---

## When to Use Each Merge Strategy

| Strategy           | Best Used When                                                                   |
| ------------------ | -------------------------------------------------------------------------------- |
| Fast Forward Merge | The target branch has not changed and a linear history is desired.               |
| Three-Way Merge    | Both branches contain new commits and complete history should be preserved.      |
| Squash Merge       | The feature branch contains many small commits and a clean history is preferred. |

---

## Advantages and Disadvantages of Squash Merge

### Advantages

* Cleaner and more readable commit history.
* One commit represents one completed feature.
* Easier to revert an entire feature if needed.

### Disadvantages

* Original commit history is not preserved in the target branch.
* Makes it difficult to identify the sequence of changes made during development.

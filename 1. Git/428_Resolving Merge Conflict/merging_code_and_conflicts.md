# Methods for Merging Code and Resolving Merge Conflicts

## 1. Methods for Merging Code

Git provides multiple ways to combine changes from one branch into another.

### Fast-Forward Merge

A Fast-Forward merge occurs when the target branch has no new commits since the feature branch was created. Git simply moves the branch pointer forward without creating a new merge commit.

Example:

```text
main:    A ── B
              \
feature:       C ── D
```

After merge:

```text
main:    A ── B ── C ── D
```

Command:

```bash
git switch main
git merge feature
```

---

### Three-Way Merge

A Three-Way merge occurs when both branches have new commits. Git creates a new merge commit that combines the histories.

Example:

```text
main:    A ── B ── E
              \
feature:       C ── D
```

After merge:

```text
main:    A ── B ── E
              \     \
feature:       C ── D ── M
```

`M` is the merge commit.

---

## 2. Resolving a Merge Conflict

A merge conflict happens when Git cannot automatically combine changes because the same part of a file was modified in different branches.

### Example

```text
<<<<<<< HEAD
Welcome to Version A
=======
Welcome to Version B
>>>>>>> feature
```

Git marks the conflicting section.

### Steps to Resolve

1. Open the conflicted file.
2. Decide which changes to keep (or combine both).
3. Remove the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).
4. Save the file.
5. Stage the resolved file.

```bash
git add file.txt
```

6. Complete the merge.

```bash
git commit
```

Git records the merge after the conflict is resolved.

---

# Extra Topics

## Fast-Forward Merge vs Three-Way Merge

| Fast-Forward Merge             | Three-Way Merge                          |
| ------------------------------ | ---------------------------------------- |
| No merge commit created        | Creates a merge commit                   |
| Simple linear history          | Preserves branch history                 |
| Used when no divergence exists | Used when both branches have new commits |

---

## Merge vs Rebase

### Merge

* Preserves complete branch history.
* Creates a merge commit.
* Recommended for team collaboration.

### Rebase

* Moves commits on top of another branch.
* Produces a cleaner, linear history.
* Avoid rebasing commits that have already been pushed to a shared repository.

---

## Best Practices for Avoiding Merge Conflicts

* Pull the latest changes before starting work.
* Keep feature branches short-lived.
* Commit changes frequently.
* Work on separate files whenever possible.
* Merge or rebase regularly to stay up to date.

---

## Using Merge Tools

Git supports external merge tools to simplify conflict resolution.

Useful commands:

```bash
git mergetool
git status
git diff
```

These tools provide a visual interface for comparing conflicting changes and help resolve conflicts more efficiently.

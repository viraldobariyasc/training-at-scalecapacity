# Git Commands Learning Notes

## 1. Configuring Git

Git configuration is the first step after installing Git. It is used to set user information that will be attached to every commit.

Common commands:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global init.defaultBranch main
git config --list
```

* `user.name` sets the commit author name.
* `user.email` sets the commit author email.
* `--global` applies the configuration to all repositories.
* `git config --list` displays all configured settings.

---

## 2. Clone and Status

### `git clone`

Creates a local copy of a remote repository.

```bash
git clone <repository-url>
```

### `git status`

Displays the current state of the repository, including:

* Modified files
* Untracked files
* Staged files
* Current branch

```bash
git status
```

---

## 3. Add, Commit and Push

### `git add`

Stages files for the next commit.

```bash
git add file.txt
git add .
```

### `git commit`

Creates a snapshot of the staged changes.

```bash
git commit -m "Add login feature"
```

A good commit message should clearly describe the changes made.

### `git push`

Uploads local commits to the remote repository.

```bash
git push origin main
```

---

## 4. Init Command

Creates a new Git repository in the current directory.

```bash
git init
```

After initialization, Git starts tracking changes inside that folder.

---

## 5. Branch Commands

Branches allow developers to work on different features independently.

Common commands:

```bash
git branch
git branch feature-login
git switch feature-login
git switch -c feature-payment
git merge feature-login
git branch -d feature-login
```

* `git branch` lists branches.
* `git switch` changes branches.
* `git merge` combines branches.
* `git branch -d` deletes a merged branch.

---

## 6. Pull Command

Downloads changes from the remote repository and merges them into the current branch.

```bash
git pull origin main
```

It is equivalent to:

```bash
git fetch
git merge
```

---

## 7. Commands for Undoing Changes

### Restore file changes

```bash
git restore file.txt
```

### Unstage a file

```bash
git restore --staged file.txt
```

### Revert a commit

```bash
git revert <commit-id>
```

### Reset to a previous commit

```bash
git reset --soft HEAD~1
git reset --mixed HEAD~1
git reset --hard HEAD~1
```

* `--soft` keeps changes staged.
* `--mixed` keeps changes unstaged.
* `--hard` removes all changes permanently.

---

## 8. Commands to Inspect and Compare

### View commit history

```bash
git log
git log --oneline
```

### Compare changes

```bash
git diff
git diff --staged
```

### Show details of a commit

```bash
git show <commit-id>
```

### View branches

```bash
git branch
```

These commands help understand project history and review code changes.

---

# Extra Topics

## Git Command Best Practices

* Write meaningful commit messages.
* Keep commits small and focused.
* Pull the latest changes before pushing.
* Create a separate branch for every feature.
* Never commit passwords or secret keys.
* Use `.gitignore` to ignore unnecessary files.

---

## Difference between `git fetch` and `git pull`

### `git fetch`

* Downloads the latest changes from the remote repository.
* Does not modify the current branch.

### `git pull`

* Downloads changes and automatically merges them into the current branch.
* Equivalent to running `git fetch` followed by `git merge`.

---

## Difference between `git merge` and `git rebase`

### `git merge`

* Combines two branches by creating a merge commit.
* Preserves complete branch history.

### `git rebase`

* Moves commits on top of another branch.
* Produces a cleaner, linear commit history.
* Should not be used on commits that have already been shared.

---

## When to use `git reset`, `git restore`, and `git revert`

### `git reset`

Used to move the current branch to an earlier commit. Mainly used for local changes.

### `git restore`

Used to discard changes in files or unstage files.

### `git revert`

Creates a new commit that reverses a previous commit. It is the safest way to undo changes in a shared repository.

---

## Git Aliases

Git aliases are shortcuts for frequently used commands.

Example:

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.cm commit
git config --global alias.lg "log --oneline --graph"
```

Now these shortcuts can be used:

```bash
git st
git co
git br
git cm
git lg
```

They improve productivity by reducing repetitive typing.

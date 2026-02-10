# Git Branch Guide: How to Move Between Branches

## Overview
This guide explains how to move (switch) from one branch to another in Git. Understanding branch navigation is essential for effective version control and collaboration.

## Basic Branch Switching

### Switch to an Existing Branch

To move from your current branch to another existing branch:

```bash
git checkout <branch-name>
```

**Example:**
```bash
git checkout main
git checkout feature-branch
git checkout copilot/move-between-branches
```

### Modern Alternative (Git 2.23+)

Git introduced a more intuitive command:

```bash
git switch <branch-name>
```

**Example:**
```bash
git switch main
git switch feature-branch
```

## Common Scenarios

### 1. Switch with a Clean Working Tree

When you have no uncommitted changes:

```bash
# Check current branch and status
git status

# Switch to another branch
git checkout <branch-name>
```

### 2. Switch with Uncommitted Changes

If you have uncommitted changes that you want to keep:

**Option A: Stash your changes**
```bash
# Save your current changes
git stash

# Switch to another branch
git checkout <branch-name>

# Later, return and restore your changes
git checkout <original-branch>
git stash pop
```

**Option B: Commit your changes**
```bash
# Commit your changes first
git add .
git commit -m "Work in progress"

# Then switch branches
git checkout <branch-name>
```

### 3. Create and Switch to a New Branch

To create a new branch and immediately switch to it:

```bash
git checkout -b <new-branch-name>
```

Or with the modern command:
```bash
git switch -c <new-branch-name>
```

**Example:**
```bash
git checkout -b feature/new-feature
```

## Viewing Available Branches

### List Local Branches
```bash
git branch
```

The current branch is marked with an asterisk (*).

### List All Branches (Local and Remote)
```bash
git branch -a
```

### List Remote Branches Only
```bash
git branch -r
```

## Switching to a Remote Branch

To switch to a branch that exists on the remote but not locally:

```bash
# Fetch latest information from remote
git fetch

# Create a local branch tracking the remote branch
git checkout -b <branch-name> origin/<branch-name>
```

Or simply:
```bash
git checkout <branch-name>
```
Git will automatically set up tracking if the branch exists on the remote.

## Best Practices

1. **Check Status First**: Always run `git status` before switching branches to see what changes you have.

2. **Commit or Stash Changes**: Avoid losing work by either committing or stashing changes before switching.

3. **Keep Branches Updated**: Regularly pull changes from the remote:
   ```bash
   git pull origin <branch-name>
   ```

4. **Use Descriptive Branch Names**: Use clear, descriptive names for branches:
   - `feature/add-user-auth`
   - `bugfix/fix-login-error`
   - `hotfix/security-patch`

5. **Clean Up Old Branches**: Delete branches you no longer need:
   ```bash
   # Delete local branch
   git branch -d <branch-name>
   
   # Force delete (if not merged)
   git branch -D <branch-name>
   ```

## Troubleshooting

### Error: "Your local changes would be overwritten by checkout"

This means you have uncommitted changes that conflict with the target branch. Solutions:
- Commit your changes: `git commit -am "Save work"`
- Stash your changes: `git stash`
- Discard your changes (careful!): `git checkout -- .`

### Error: "pathspec did not match any file(s) known to git"

The branch doesn't exist locally. Try:
```bash
git fetch
git checkout <branch-name>
```

## Quick Reference

| Command | Description |
|---------|-------------|
| `git branch` | List local branches |
| `git branch -a` | List all branches |
| `git checkout <branch>` | Switch to existing branch |
| `git switch <branch>` | Switch to existing branch (modern) |
| `git checkout -b <branch>` | Create and switch to new branch |
| `git switch -c <branch>` | Create and switch to new branch (modern) |
| `git stash` | Save uncommitted changes |
| `git stash pop` | Restore stashed changes |
| `git status` | Check current branch and changes |

## Example Workflow

```bash
# Check current status
git status

# View available branches
git branch -a

# Switch to main branch
git checkout main

# Pull latest changes
git pull origin main

# Create and switch to a new feature branch
git checkout -b feature/my-new-feature

# Make changes, commit them
git add .
git commit -m "Add new feature"

# Switch back to main
git checkout main

# Switch to another existing branch
git checkout copilot/move-between-branches
```

## Summary

Moving between branches in Git is straightforward:
- Use `git checkout <branch-name>` or `git switch <branch-name>` to switch branches
- Handle uncommitted changes by committing or stashing them
- Use `git branch` to see available branches
- Create new branches with `git checkout -b <branch-name>`

For more information, consult the [official Git documentation](https://git-scm.com/doc).

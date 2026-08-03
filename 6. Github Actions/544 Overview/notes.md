# 1. Overview

GitHub Actions is GitHub's built-in **CI/CD (Continuous Integration and Continuous Delivery/Deployment)** platform.

It allows you to automate software development workflows directly from your GitHub repository without requiring a separate CI/CD server like Jenkins.

Instead of manually building, testing, and deploying your application after every code change, GitHub Actions can perform these tasks automatically whenever a specific event occurs.

Examples of automation:

- Build a Java application
- Run unit tests
- Build Docker images
- Push Docker images to Docker Hub or Amazon ECR
- Deploy to AWS EC2, ECS, EKS, or S3
- Send Slack or Email notifications
- Execute security scans

---

# 2. Why Do We Need GitHub Actions?

Imagine a team of developers working on the same project.

Without automation:

```
Developer

↓

Push Code

↓

Login to Build Server

↓

Run Build

↓

Run Tests

↓

Deploy Application

↓

Verify Deployment
```

Problems:

- Manual effort
- Slow deployments
- Human errors
- Inconsistent builds
- Difficult collaboration

With GitHub Actions:

```
Developer

↓

git push

↓

GitHub Repository

↓

GitHub Actions

↓

Build

↓

Test

↓

Deploy
```

Everything happens automatically based on predefined workflows.

---

# 3. What is CI/CD?

## Continuous Integration (CI)

Continuous Integration means automatically building and testing the application whenever code is pushed.

Typical CI tasks:

- Checkout source code
- Install dependencies
- Compile application
- Run tests
- Generate reports

Purpose:

- Detect bugs early
- Ensure code quality
- Prevent broken code from reaching production

---

## Continuous Delivery (CD)

Application is automatically prepared for deployment.

Deployment is approved manually.

```
Developer

↓

Build

↓

Tests

↓

Ready for Deployment
```

---

## Continuous Deployment

Deployment happens automatically after successful tests.

```
Developer

↓

Push Code

↓

Build

↓

Test

↓

Deploy Automatically
```

---

# 4. GitHub Actions Architecture

GitHub Actions consists of several components.

```
Developer

↓

Git Push

↓

GitHub Repository

↓

Workflow

↓

Runner

↓

Job

↓

Steps

↓

Application
```

Main components:

- Repository
- Workflow
- Event
- Runner
- Job
- Step
- Action

---

# 5. Core Components

## 5.1 Workflow

A Workflow is an automation process.

It is written in YAML and stored inside:

```
.github/workflows/
```

Example:

```
.github/

└── workflows/

    └── ci.yml
```

A repository can contain multiple workflows.

---

## 5.2 Event

Events decide **when** a workflow starts.

Examples:

- push
- pull_request
- workflow_dispatch
- release
- schedule

Example:

```
Git Push

↓

Workflow Starts
```

---

## 5.3 Job

A workflow contains one or more jobs.

Example:

```
Workflow

├── Build

├── Test

└── Deploy
```

Jobs run independently unless dependencies are defined.

---

## 5.4 Step

Each job contains multiple steps.

Example:

```
Build Job

↓

Checkout Code

↓

Install Java

↓

Run Maven

↓

Upload Artifact
```

---

## 5.5 Action

An Action is a reusable unit of work.

Example:

```
uses: actions/checkout@v4
```

This action checks out the repository automatically.

GitHub Marketplace provides thousands of reusable actions.

---

# 6. Runners

A Runner is the machine that executes your workflow.

Without a runner, GitHub Actions cannot perform any task.

---

## GitHub-hosted Runner

GitHub provides virtual machines.

Supported operating systems:

- Ubuntu
- Windows
- macOS

Advantages:

- No setup
- Automatically maintained
- Easy to use

---

## Self-hosted Runner

You provide your own machine.

Example:

- EC2
- Azure VM
- Local Server
- Kubernetes Node

Advantages:

- More control
- Custom software
- Private network access

Disadvantages:

- Maintenance responsibility
- Security management

---

# 7. Workflow Execution Flow

A typical workflow execution:

```
Developer

↓

git push

↓

GitHub Repository

↓

Trigger Event

↓

Workflow

↓

Runner Starts

↓

Checkout Code

↓

Build

↓

Test

↓

Deploy

↓

Workflow Complete
```

---

# 8. GitHub Actions vs Jenkins

| Feature | GitHub Actions | Jenkins |
|----------|---------------|----------|
| Installation | Built into GitHub | Self-hosted |
| Configuration | YAML | UI + Jenkinsfile |
| Maintenance | Managed by GitHub | User managed |
| Plugins | GitHub Marketplace | Large Plugin Ecosystem |
| Infrastructure | GitHub-hosted Runners | Controller + Agents |
| Best For | GitHub repositories | Complex enterprise CI/CD |

---

# 9. Practical

## Objective

Run your first GitHub Actions workflow.

### Prerequisites

- GitHub Account
- Git Repository

### Step 1

Open your repository.

Click:

```
Actions
```

---

### Step 2

Choose a starter workflow.

Example:

```
Java with Maven
```

or

```
Simple Workflow
```

GitHub automatically creates:

```
.github/workflows/main.yml
```

---

### Step 3

Commit the workflow.

GitHub immediately detects it.

---

### Step 4

Push a small code change.

```bash
git add .

git commit -m "Trigger workflow"

git push origin main
```

---

### Step 5

Navigate to:

```
Repository

↓

Actions
```

Observe:

- Running workflow
- Individual jobs
- Individual steps
- Logs

---

### Expected Output

```
✔ Checkout

✔ Build

✔ Test

Workflow completed successfully
```

---

# 10. Advantages

- Built directly into GitHub
- Easy to configure
- Supports Linux, Windows, and macOS
- Large Marketplace of reusable Actions
- Version-controlled workflows
- No separate CI server required
- Easy integration with cloud providers

---

# 11. Limitations

- Best suited for GitHub repositories
- Usage limits on free plans
- Self-hosted runners require maintenance
- Complex enterprise workflows may require additional planning

---

# 12. Best Practices

- Store workflows inside `.github/workflows`.
- Keep workflows modular.
- Use reusable Actions instead of writing everything from scratch.
- Store sensitive values as GitHub Secrets.
- Separate Build, Test, and Deploy into different jobs when appropriate.
- Keep workflow files under version control.

---

# 13. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Workflow not starting | Event not configured | Verify the `on:` trigger |
| Workflow file ignored | Wrong directory | Ensure it's inside `.github/workflows/` |
| Runner unavailable | Incorrect `runs-on` value | Use a valid GitHub-hosted label or configure a self-hosted runner |
| Build failed | Compilation/test error | Review workflow logs |
| Permission denied | Missing repository permissions or secrets | Configure repository permissions and GitHub Secrets |

---

# 14. Interview Questions

1. What is GitHub Actions?
2. Why is GitHub Actions used?
3. What is a Workflow?
4. What is an Event?
5. What is a Job?
6. What is a Step?
7. What is an Action?
8. What is a Runner?
9. Difference between GitHub-hosted and Self-hosted runners.
10. GitHub Actions vs Jenkins.
11. Explain the execution flow of a GitHub Actions workflow.
12. Where are workflow files stored?

---

# 15. Summary

- GitHub Actions is GitHub's native CI/CD platform for automating software development workflows.
- Workflows are defined as YAML files inside the `.github/workflows` directory.
- A workflow is triggered by an event, executed by a runner, and consists of one or more jobs, each containing multiple steps.
- GitHub-hosted runners are managed by GitHub, while self-hosted runners provide greater control and customization.
- GitHub Actions integrates seamlessly with GitHub repositories, making it an excellent choice for automating builds, tests, and deployments.
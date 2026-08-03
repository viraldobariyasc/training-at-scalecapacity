# notes.md

# 1. Overview

A GitHub Actions **Pipeline** is called a **Workflow**.

It is a YAML file that contains all the instructions required to build, test, and deploy an application automatically.

Unlike Jenkins, where pipelines are usually stored as a **Jenkinsfile**, GitHub Actions stores workflows inside:

```
.github/workflows/
```

Example:

```
MyProject/

├── src/

├── pom.xml

├── Dockerfile

└── .github/
    └── workflows/
        └── ci.yml
```

Whenever a configured event occurs (such as a Git push), GitHub reads the workflow file and executes it.

---

# 2. Workflow File Structure

Every workflow follows a similar structure.

```yaml
name:

on:

jobs:

  job-name:

    runs-on:

    steps:
```

Each keyword has a specific purpose.

| Keyword | Purpose |
|----------|----------|
| name | Workflow name shown in GitHub |
| on | Event that triggers the workflow |
| jobs | Collection of jobs |
| runs-on | Runner used for execution |
| steps | Individual tasks |
| uses | Executes an existing Action |
| run | Executes shell commands |

---

# 3. Creating Your First Pipeline

Create the following directory:

```
.github/

└── workflows/
```

Inside it create:

```
first-pipeline.yml
```

Example:

```yaml
name: My First Pipeline

on:
  push:

jobs:
  hello-job:

    runs-on: ubuntu-latest

    steps:

      - name: Print Message
        run: echo "Hello GitHub Actions"
```

Commit the file.

Every Git push will now trigger the workflow automatically.

---

# 4. Understanding the Workflow

```
name:
```

Friendly name displayed inside GitHub Actions.

Example:

```yaml
name: Java CI Pipeline
```

---

```
on:
```

Defines **when** the workflow executes.

Example:

```yaml
on:
  push:
```

Other examples:

```yaml
on:
  pull_request:
```

```yaml
on:
  workflow_dispatch:
```

```yaml
on:
  schedule:
```

---

```
jobs:
```

A workflow can contain multiple jobs.

Example:

```
Workflow

├── Build

├── Test

└── Deploy
```

Jobs run independently unless dependencies are configured.

---

```
runs-on:
```

Specifies which runner executes the job.

Example:

```yaml
runs-on: ubuntu-latest
```

Other options:

```yaml
runs-on: windows-latest
```

```yaml
runs-on: macos-latest
```

---

```
steps:
```

Each job contains one or more steps.

Example:

```yaml
steps:

- run: echo "Hello"
```

---

# 5. Using Existing Actions

Instead of writing everything yourself, GitHub provides reusable Actions.

Example:

```yaml
- uses: actions/checkout@v4
```

Purpose:

Downloads your repository onto the runner.

Without this step, your project files are **not available**.

Another example:

```yaml
- uses: actions/setup-java@v4
```

Purpose:

Installs Java automatically.

---

# 6. Running Commands

Use:

```yaml
run:
```

to execute shell commands.

Example:

```yaml
- run: pwd

- run: ls

- run: java -version
```

Multiple commands:

```yaml
- run: |
    pwd
    ls
    java -version
```

---

# 7. Java Maven Pipeline Example

```yaml
name: Java CI

on:
  push:

jobs:

  build:

    runs-on: ubuntu-latest

    steps:

      - name: Checkout Source
        uses: actions/checkout@v4

      - name: Install Java
        uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: 21

      - name: Build Application
        run: mvn clean package
```

Pipeline Flow:

```
Git Push

↓

Checkout Code

↓

Install Java

↓

Run Maven

↓

Pipeline Success
```

---

# 8. Manual Pipeline Execution

Sometimes you want to run a workflow manually.

Example:

```yaml
on:

  workflow_dispatch:
```

Now GitHub displays:

```
Run Workflow
```

button inside the Actions tab.

---

# 9. Viewing Pipeline Logs

Navigate to:

```
Repository

↓

Actions

↓

Workflow

↓

Job

↓

Step
```

You can view:

- Execution time
- Commands executed
- Errors
- Warnings
- Success messages

Example:

```
Checkout Repository

Completed

Setup Java

Completed

Run Maven

BUILD SUCCESS
```

---

# 10. Practical

## Objective

Build a Java application automatically after every Git push.

### Prerequisites

- GitHub Repository
- Java Maven Project
- Maven Wrapper (`mvnw`) or Maven installed
- Workflow file

### Step 1

Create:

```
.github/workflows/java-ci.yml
```

### Step 2

Paste:

```yaml
name: Java Build

on:
  push:

jobs:

  build:

    runs-on: ubuntu-latest

    steps:

      - uses: actions/checkout@v4

      - uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: 21

      - run: mvn clean package
```

### Step 3

Commit and push:

```bash
git add .

git commit -m "Added GitHub Actions pipeline"

git push origin main
```

### Step 4

Open the **Actions** tab.

Observe:

- Workflow
- Job
- Steps
- Logs

### Expected Output

```
Checkout Repository

✔

Setup Java

✔

Run Maven

BUILD SUCCESS

Workflow completed successfully
```

---

# 11. Best Practices

- Store all workflows inside `.github/workflows`.
- Use meaningful workflow names.
- Separate Build, Test, and Deploy into different jobs for complex projects.
- Use official GitHub Actions where possible.
- Keep workflows under version control.
- Validate workflow syntax before committing.

---

# 12. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Workflow not visible | Wrong folder | Store it in `.github/workflows` |
| Maven command failed | Maven not installed or project issue | Use `setup-java` and ensure Maven Wrapper is available |
| Checkout failed | Repository permissions | Verify repository access |
| Invalid YAML | Incorrect indentation | Check spacing (YAML is indentation-sensitive) |
| Workflow not triggered | Incorrect `on:` event | Verify trigger configuration |

---

# 13. Interview Questions

1. What is a GitHub Actions pipeline?
2. Where are workflow files stored?
3. Explain the purpose of `name`, `on`, `jobs`, `runs-on`, and `steps`.
4. What is the purpose of `actions/checkout`?
5. Why is `actions/setup-java` used?
6. What is `workflow_dispatch`?
7. How do you view workflow logs?
8. Difference between `uses` and `run`.
9. Can a workflow contain multiple jobs?
10. What are common reasons a workflow does not trigger?

---

# 14. Summary

- A GitHub Actions pipeline is defined as a YAML workflow file stored in `.github/workflows/`.
- A workflow consists of triggers (`on`), jobs, runners, and steps.
- Official Actions like `actions/checkout` and `actions/setup-java` simplify common tasks.
- Pipelines can run automatically on events such as `push` or `pull_request`, or manually using `workflow_dispatch`.
- Understanding workflow structure is the foundation for building more advanced CI/CD pipelines with testing, Docker, cloud deployments, and reusable workflows.
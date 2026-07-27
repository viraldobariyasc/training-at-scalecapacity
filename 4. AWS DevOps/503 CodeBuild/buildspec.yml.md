# buildspec.yml - Complete Notes (AWS CodeBuild)

---

# What is `buildspec.yml`?

`buildspec.yml` is a YAML configuration file that tells **AWS CodeBuild** **what commands to execute and in what order** during a build.

Think of it as the **recipe** or **script** for your build process.

Without a `buildspec.yml`, CodeBuild doesn't know:

* How to install dependencies
* How to build the project
* How to run tests
* What artifacts to upload
* What reports to generate

---

# Where is it stored?

Normally at the root of your source repository.

```
my-app/
│
├── src/
├── package.json
├── package-lock.json
├── buildspec.yml
└── README.md
```

When CodeBuild downloads the source, it automatically searches for:

```
buildspec.yml
```

in the project root.

You can also specify a custom path while creating the CodeBuild project.

Example:

```
config/buildspec-dev.yml
```

or

```
buildspecs/buildspec-prod.yml
```

---

# Why is it called buildspec?

**Build Specification**

It specifies everything required to perform a build.

---

# File Format

It uses **YAML**.

Example:

```yaml
version: 0.2

phases:
  install:
    commands:
      - npm install

  build:
    commands:
      - npm run build

artifacts:
  files:
    - '**/*'
```

---

# Basic Structure

```text
version
│
├── env
│
├── proxy
│
├── batch
│
├── phases
│      ├── install
│      ├── pre_build
│      ├── build
│      └── post_build
│
├── reports
│
├── artifacts
│
└── cache
```

Most projects use only:

* version
* env
* phases
* artifacts
* cache

---

# Version

Currently AWS supports

```yaml
version: 0.2
```

Version 0.2 introduced improvements over 0.1, such as running commands in the same shell within a phase, making variable handling more predictable.

---

# Phases

The execution order is fixed.

```
install
      ↓
pre_build
      ↓
build
      ↓
post_build
```

You **cannot** change this order.

You **cannot** rename these phases.

You **cannot** add custom phases.

---

## 1. install

Purpose:

Prepare the build environment.

Typical tasks:

* Install dependencies
* Select runtime
* Install CLI tools
* Download utilities

Example

```yaml
install:
  runtime-versions:
    nodejs: 20

  commands:
    - npm install
```

---

### runtime-versions

Supported **only** inside the `install` phase.

Example

```yaml
runtime-versions:
  nodejs: 20
  java: corretto21
  python: 3.12
```

Once selected, these runtimes are available throughout **all phases** of the build.

You cannot redefine them later.

---

## 2. pre_build

Purpose:

Execute tasks before the main build.

Examples:

Login to Amazon ECR

```bash
aws ecr get-login-password ...
```

Run linting

```bash
npm run lint
```

Run tests

```bash
npm test
```

Generate configuration

Authenticate with external services

---

## 3. build

Purpose:

Compile or build the application.

Examples

Node

```bash
npm run build
```

Java

```bash
mvn package
```

Gradle

```bash
gradle build
```

.NET

```bash
dotnet publish
```

Docker

```bash
docker build
```

This is the primary phase where your application is built.

---

## 4. post_build

Purpose:

Execute tasks after the build finishes.

Examples

Push Docker image

```bash
docker push
```

Upload reports

Invalidate CloudFront

Send notifications

Create deployment packages

Tag Docker images

Cleanup

---

# commands

Every phase executes commands sequentially.

```yaml
commands:
  - command1
  - command2
  - command3
```

Example

```yaml
commands:
  - pwd
  - ls -la
  - npm install
```

If one command fails (non-zero exit code), CodeBuild stops the build by default.

---

# finally

Commands that should execute regardless of success or failure.

Example

```yaml
build:
  commands:
    - npm run build

  finally:
    - echo "Cleaning temporary files"
```

Useful for cleanup or collecting logs.

---

# on-failure

Controls behavior when a phase fails.

Example

```yaml
build:
  on-failure: ABORT
```

Common values:

* `ABORT` (default)
* `CONTINUE`

`CONTINUE` allows the build to proceed to the next phase despite a failure in the current phase. Use with care.

---

# Environment Variables

```yaml
env:
  variables:
    ENV: production
    PORT: 3000
```

Access them:

```bash
echo $ENV
```

---

## Parameter Store

```yaml
env:
  parameter-store:
    DB_PASSWORD: /prod/db/password
```

CodeBuild fetches the value from AWS Systems Manager Parameter Store at build time.

---

## Secrets Manager

```yaml
env:
  secrets-manager:
    TOKEN: github-secret:token
```

Used to securely inject secrets into the build.

---

# Artifacts

Artifacts are the output files produced by the build.

Example

```yaml
artifacts:
  files:
    - '**/*'
```

Only these files are uploaded to the configured artifact destination (typically S3 or passed to CodePipeline).

---

Example

```
dist/

    index.html
    app.js
    style.css
```

```yaml
artifacts:
  files:
    - dist/**/*
```

Only the `dist` folder will be uploaded.

---

## Common Artifact Patterns

Entire project

```yaml
files:
  - '**/*'
```

Only build output

```yaml
files:
  - dist/**/*
```

JAR

```yaml
files:
  - target/*.jar
```

ZIP

```yaml
files:
  - app.zip
```

---

# Reports

Upload test reports or code coverage.

Example

```yaml
reports:
  junit:
    files:
      - reports/*.xml
```

Supported report formats include JUnit and other common test report formats.

---

# Cache

Improves build speed by reusing dependencies between builds.

Node

```yaml
cache:
  paths:
    - node_modules/**/*
```

Maven

```yaml
cache:
  paths:
    - ~/.m2/**/*
```

Gradle

```yaml
cache:
  paths:
    - ~/.gradle/**/*
```

Without cache:

```
Build 1
↓

npm install
↓

5 minutes
```

With cache:

```
Build 2
↓

Uses cached node_modules

↓

1 minute
```

---

# Execution Flow

```
Source Downloaded
        │
        ▼
Read buildspec.yml
        │
        ▼
Install Runtime
        │
        ▼
install
        │
        ▼
pre_build
        │
        ▼
build
        │
        ▼
post_build
        │
        ▼
Upload Artifacts
        │
        ▼
Build Ends
```

---

# Sample buildspec.yml (Node.js)

```yaml
version: 0.2

env:
  variables:
    NODE_ENV: production

phases:
  install:
    runtime-versions:
      nodejs: 20
    commands:
      - echo Installing dependencies
      - npm install

  pre_build:
    commands:
      - echo Running lint
      - npm run lint

  build:
    commands:
      - echo Building application
      - npm run build

  post_build:
    commands:
      - echo Build completed

artifacts:
  files:
    - dist/**/*

cache:
  paths:
    - node_modules/**/*
```

---

# Production Example (Docker + ECR)

```yaml
version: 0.2

phases:
  pre_build:
    commands:
      - aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com

  build:
    commands:
      - docker build -t myapp .
      - docker tag myapp:latest $ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/myapp:latest

  post_build:
    commands:
      - docker push $ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/myapp:latest
```

This pattern is commonly used in CI/CD pipelines before deployment to ECS, EKS, or other container platforms.

---

# Common Mistakes

1. **Incorrect YAML indentation** — YAML is indentation-sensitive.
2. **Using tabs instead of spaces** — use spaces only.
3. **Wrong phase names** (`compile`, `deploy`, etc.) — only the predefined phases are supported.
4. **Placing `runtime-versions` outside `install`** — not supported.
5. **Forgetting to include build output in `artifacts`** — results in missing output for downstream stages.
6. **Using unsupported runtime versions** for the selected CodeBuild image.
7. **Committing secrets directly into `buildspec.yml`** instead of using Parameter Store or Secrets Manager.

---

# Interview Questions

### 1. What is `buildspec.yml`?

A YAML file that defines the commands, phases, environment variables, artifacts, reports, and cache configuration for an AWS CodeBuild project.

### 2. Can you create custom phases?

No. CodeBuild supports only `install`, `pre_build`, `build`, and `post_build`.

### 3. Can runtime versions be changed during the build?

No. `runtime-versions` can only be specified in the `install` phase and remain in effect for the entire build.

### 4. What is the difference between artifacts and cache?

* **Artifacts** are outputs of the current build that are uploaded for later use (for example, by CodePipeline or to S3).
* **Cache** stores reusable dependencies across builds to reduce build time.

### 5. What happens if a command fails?

By default, the phase and build stop immediately unless configured otherwise (for example, using `on-failure: CONTINUE` in supported scenarios).

### 6. Where should sensitive values like passwords or API tokens be stored?

Use **AWS Systems Manager Parameter Store** or **AWS Secrets Manager**, and reference them through the `env` section rather than hardcoding them in `buildspec.yml`.

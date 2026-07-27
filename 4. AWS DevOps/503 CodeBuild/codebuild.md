# CodeBuild-notes.md

# 1. AWS CodeBuild

## 1.1 Objective

After completing this module, you should be able to:

- Understand why build automation is required.
- Explain where AWS CodeBuild fits in a CI/CD pipeline.
- Create and configure CodeBuild projects.
- Configure `buildspec.yml`.
- Build Java, Node.js, and Docker applications.
- Push Docker images to Amazon ECR.
- Debug failed builds.
- Perform local builds.
- Apply production best practices.

---

# 2. Why Build Automation?

Before understanding CodeBuild, let's understand the problem it solves.

Imagine a developer writes a Spring Boot application.

```
Developer

↓

git push

↓

GitHub
```

Now someone has to:

- Clone repository
- Install Java
- Install Maven
- Download dependencies
- Compile code
- Run tests
- Package JAR
- Build Docker image
- Push Docker image

If a human performs these steps manually:

- Time consuming
- Error prone
- Different machines produce different results
- Difficult to reproduce

This is where Build Automation comes in.

---

# 3. What is a Build?

Many beginners think build means compilation.

Actually, build is much more than that.

A build may include:

```
Download Source Code

↓

Install Dependencies

↓

Compile

↓

Run Unit Tests

↓

Static Code Analysis

↓

Package Application

↓

Generate Reports

↓

Create Docker Image

↓

Upload Artifact
```

Depending on the project, not every step is required.

---

# 4. What is AWS CodeBuild?

AWS CodeBuild is a fully managed build service.

It automatically provisions a temporary build environment, executes your build commands, stores logs, uploads artifacts, and then destroys the environment.

You never manage:

- EC2
- Virtual Machine
- Operating System
- Patch Management
- Scaling

AWS does all of that.

---

## 4.1 Official Definition

> AWS CodeBuild is a fully managed continuous integration service that compiles source code, runs tests, and produces software packages ready for deployment.

---

## 4.2 Real World Analogy

Imagine a bakery.

Without CodeBuild:

Developer is the baker.

```
Receive Order

↓

Prepare Ingredients

↓

Bake

↓

Package

↓

Deliver
```

Developer does everything.

With CodeBuild

```
Developer

↓

Receives Order

↓

Automated Bakery

↓

Cake Ready
```

Developer only pushes code.

Everything else is automated.

---

# 5. Why AWS Created CodeBuild

Before CodeBuild, companies used:

- Jenkins
- Bamboo
- TeamCity

Problem:

Someone had to maintain these servers.

```
Install Jenkins

↓

Update Plugins

↓

Patch Server

↓

Backup

↓

Monitor

↓

Scale
```

All of these are infrastructure tasks.

AWS wanted customers to focus only on application builds.

So AWS introduced CodeBuild.

---

# 6. Where CodeBuild Fits in CI/CD

Typical DevOps pipeline:

```
Developer

↓

Git Push

↓

GitHub

↓

CodePipeline

↓

CodeBuild

↓

Amazon ECR

↓

CodeDeploy / ECS / EKS
```

CodeBuild is responsible only for building.

It does NOT deploy your application.

---

# 7. Internal Working of CodeBuild

Many people know how to use CodeBuild but don't know what happens internally.

Suppose you click

```
Start Build
```

AWS performs the following:

### Step 1

Allocates compute.

```
Temporary Build Container

Ubuntu

4 GB RAM

2 vCPU
```

---

### Step 2

Downloads source code.

Example:

GitHub Repository

↓

Clone

↓

Temporary Container

---

### Step 3

Reads buildspec.yml

```
version: 0.2

phases:
```

This file tells CodeBuild what commands to execute.

---

### Step 4

Runs commands.

Example

```
mvn clean package

npm install

docker build

pytest
```

---

### Step 5

Stores logs.

Logs go to

CloudWatch Logs.

---

### Step 6

Uploads artifacts.

Possible destinations

- Amazon S3
- CodePipeline
- Amazon ECR

---

### Step 7

Deletes build container.

Important:

CodeBuild environments are **ephemeral**.

Nothing remains after build finishes unless you explicitly upload artifacts.

---

# 8. CodeBuild Architecture

```
               GitHub

                  │

                  ▼

          AWS CodeBuild

        Temporary Container

       ┌──────────────────┐
       │ Install          │
       │ Pre Build        │
       │ Build            │
       │ Post Build       │
       └──────────────────┘

        │            │

        ▼            ▼

 CloudWatch      Amazon S3

                  or

                 Amazon ECR
```

---

# 9. Important Components

## 9.1 Source

Where code comes from.

Supported sources

- GitHub
- GitHub Enterprise
- Bitbucket
- AWS CodeCommit
- Amazon S3
- CodePipeline

Example

```
GitHub

↓

Clone Repository

↓

Start Build
```

---

## 9.2 Environment

Environment is the machine where build runs.

Contains

- Operating System
- Runtime
- Installed Software
- CPU
- Memory

Example

Ubuntu

Java 21

Docker

Git

Maven

Python

---

## 9.3 Service Role

CodeBuild itself needs AWS permissions.

Example

```
Pull Image

↓

Amazon ECR
```

or

```
Upload Artifact

↓

Amazon S3
```

These permissions come from the Service Role.

Never use AdministratorAccess.

Grant least privilege.

---

## 9.4 Buildspec

The heart of CodeBuild.

Without build commands, CodeBuild doesn't know what to execute.

---

## 9.5 Artifacts

Artifacts are outputs generated by the build.

Examples

- JAR
- WAR
- ZIP
- Docker Image
- HTML Report

---

# 10. CodeBuild Sources

## GitHub

Most common source.

```
GitHub

↓

Webhook

↓

CodeBuild
```

Every push can automatically trigger a build.

---

## Amazon S3

Useful when source is uploaded manually.

```
ZIP File

↓

Amazon S3

↓

CodeBuild
```

---

## CodeCommit

AWS managed Git repository.

---

## CodePipeline

Most production environments use CodePipeline.

```
GitHub

↓

Pipeline

↓

CodeBuild
```

Pipeline controls execution.

---

# 11. Build Lifecycle

Every build follows this lifecycle.

```
Queued

↓

Provisioning

↓

Download Source

↓

Install

↓

Pre Build

↓

Build

↓

Post Build

↓

Upload Artifacts

↓

Complete
```

Understanding this lifecycle helps debug failures.

---

# 12. buildspec.yml

Every build project usually contains

```
buildspec.yml
```

This file lives in project root.

Example

```
project/

src/

pom.xml

buildspec.yml
```

CodeBuild automatically searches for this file.

If it cannot find it,

Build fails.

---

## 12.1 Basic Example

```yaml
version: 0.2

phases:
  install:
    commands:
      - echo Installing dependencies
      - mvn --version

  build:
    commands:
      - mvn clean package

artifacts:
  files:
    - target/*.jar
```

---

## Explanation

```
install

↓

Install tools

↓

build

↓

Compile application

↓

artifacts

↓

Upload generated JAR
```

---

# 13. Build Phases

## Install

Install dependencies.

Example

```bash
npm install

pip install -r requirements.txt
```

---

## Pre Build

Tasks before compilation.

Example

```
Login to Amazon ECR

Run validations

Export variables
```

---

## Build

Actual compilation.

Examples

```bash
mvn clean package

npm run build

go build
```

---

## Post Build

Executed after successful build.

Example

```bash
docker push

Upload Reports

Notify Pipeline
```

---

# 14. Practical 1 – Java Build

## Objective

Build a Spring Boot application.

---

## Prerequisites

- GitHub repository
- pom.xml
- AWS account
- IAM role
- CodeBuild project

---

## Steps

### Step 1

Push project.

```
GitHub

↓

Spring Boot
```

---

### Step 2

Create CodeBuild Project.

Name

```
springboot-build
```

---

### Step 3

Choose Source

GitHub

---

### Step 4

Choose Managed Image

Ubuntu

Standard Runtime

Java 21

---

### Step 5

Create buildspec.yml

```yaml
version: 0.2

phases:

  build:
    commands:
      - mvn clean package

artifacts:
  files:
    - target/*.jar
```

---

### Step 6

Start Build.

---

## Expected Output

```
BUILD SUCCESS

target/

application.jar
```

Artifact uploaded successfully.

---

## Verification

Open

Build History

↓

Logs

↓

Confirm

```
BUILD SUCCEEDED
```

---

# 15. Practical 2 – Build Docker Image

Project

```
Dockerfile

app

buildspec.yml
```

Example

```yaml
version: 0.2

phases:

  pre_build:
    commands:
      - aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com

  build:
    commands:
      - docker build -t my-app .
      - docker tag my-app:latest <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/my-app:latest

  post_build:
    commands:
      - docker push <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/my-app:latest
```

Flow

```
GitHub

↓

CodeBuild

↓

Docker Build

↓

Docker Tag

↓

Push Image

↓

Amazon ECR
```

---

# 16. Local Builds

AWS provides CodeBuild Local Agent.

Useful for:

- Testing buildspec.yml
- Faster debugging
- No AWS charges

Typical flow

```
Laptop

↓

Docker

↓

CodeBuild Local Agent

↓

Execute buildspec.yml
```

Always validate complex builds locally before pushing.

---

# 17. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| YAML_FILE_ERROR | Invalid YAML | Fix indentation |
| BUILD_FAILED | Command failed | Check logs |
| AccessDenied | IAM issue | Update service role |
| CannotPullContainerError | Image unavailable | Verify image |
| Docker daemon not running | Docker disabled | Enable privileged mode |
| Artifact upload failed | Wrong S3 permission | Update IAM |

---

# 18. Best Practices

- Store `buildspec.yml` in version control.
- Use IAM least privilege.
- Never hardcode secrets.
- Store secrets in Secrets Manager or Parameter Store.
- Enable CloudWatch Logs.
- Cache dependencies where appropriate.
- Use immutable Docker image tags.
- Keep builds deterministic.
- Fail builds immediately on test failures.
- Separate build and deployment responsibilities.

---

# 19. Interview Questions

1. What problem does AWS CodeBuild solve?
2. Why is CodeBuild called a serverless build service?
3. What happens internally when a build starts?
4. Explain the CodeBuild lifecycle.
5. What is `buildspec.yml`?
6. Explain each build phase.
7. Difference between artifacts and source.
8. Why is CodeBuild environment ephemeral?
9. How does CodeBuild authenticate with ECR?
10. Difference between CodeBuild and Jenkins.
11. When should you use CodePipeline with CodeBuild?
12. What is Privileged Mode and why is it required for Docker builds?

---

# 20. Summary

- CodeBuild is AWS's managed build service used for Continuous Integration (CI).
- It provisions a temporary build environment, executes commands from `buildspec.yml`, stores logs in CloudWatch, uploads artifacts, and automatically destroys the build environment after completion.
- Source code can come from GitHub, CodeCommit, S3, Bitbucket, or CodePipeline.
- The most important file is `buildspec.yml`, which defines every step of the build process.
- CodeBuild integrates seamlessly with Amazon ECR, S3, ECS, EKS, CodeDeploy, and CodePipeline, making it a core service in AWS CI/CD pipelines.
- In production, use IAM least privilege, Secrets Manager, CloudWatch Logs, dependency caching, immutable image tags, and automated triggers to build secure and reliable pipelines.


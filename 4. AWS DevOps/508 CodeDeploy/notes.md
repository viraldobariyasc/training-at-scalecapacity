# CodeDeploy-notes.md

# 1. AWS CodeDeploy

## 1.1 Learning Objectives

After completing this module, you should be able to:

- Explain why CodeDeploy is required.
- Understand how CodeDeploy works internally.
- Install and configure the CodeDeploy Agent.
- Create and understand `appspec.yml`.
- Deploy applications to EC2, ECS, and Auto Scaling Groups.
- Perform zero-downtime deployments.
- Configure automatic rollback.
- Troubleshoot common deployment failures.
- Apply production best practices.

---

# 2. Introduction

Before CodeDeploy, let's understand the deployment problem.

Suppose you have a Java application running on an EC2 instance.

```
EC2

└── Spring Boot Application
```

A developer makes changes and pushes new code.

Now someone has to:

- SSH into EC2
- Stop the application
- Copy new JAR
- Replace old JAR
- Restart application
- Verify logs

Imagine you have **50 EC2 instances**.

```
EC2-1

EC2-2

EC2-3

...

EC2-50
```

Will you SSH into all 50 servers manually?

Obviously not.

This is where deployment automation becomes necessary.

---

# 3. What is Deployment?

Many beginners confuse **Build** and **Deployment**.

### Build

Produces an application.

Example

```
Source Code

↓

Compile

↓

application.jar
```

### Deployment

Moves that application to servers and starts it.

```
application.jar

↓

EC2

↓

Application Running
```

Remember

> **CodeBuild creates the package. CodeDeploy installs the package.**

---

# 4. What is AWS CodeDeploy?

AWS CodeDeploy is a **fully managed deployment service**.

It automates deploying applications to:

- Amazon EC2
- Auto Scaling Groups
- Amazon ECS
- AWS Lambda (not covered in this module)

Instead of manually copying files and restarting applications, CodeDeploy performs these tasks automatically.

---

## 4.1 Official Definition

> AWS CodeDeploy is a deployment service that automates software deployments to compute services such as EC2, ECS, Lambda, and on-premises servers.

---

# 5. Why Do We Need CodeDeploy?

Without CodeDeploy

```
Developer

↓

SSH into EC2

↓

Stop Application

↓

Copy Files

↓

Restart

↓

Check Logs
```

Problems:

- Human errors
- Different commands on different servers
- Downtime
- Difficult rollback
- No deployment history

With CodeDeploy

```
Developer

↓

Upload Revision

↓

CodeDeploy

↓

Deploy Everywhere

↓

Monitor

↓

Rollback if Needed
```

Benefits:

- Automation
- Consistency
- Zero downtime
- Deployment history
- Easy rollback

---

# 6. Where CodeDeploy Fits in CI/CD

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

Build Artifact

↓

CodeDeploy

↓

EC2 / ECS
```

Responsibilities:

| Service | Responsibility |
|----------|---------------|
| GitHub | Source Code |
| CodeBuild | Build Application |
| CodeDeploy | Deploy Application |
| CodePipeline | Orchestrate Entire Pipeline |

---

# 7. Internal Working of CodeDeploy

Suppose you click **Create Deployment**.

What happens internally?

### Step 1

CodeDeploy receives deployment request.

↓

### Step 2

Downloads deployment package.

Example

```
Amazon S3

or

GitHub

or

CodePipeline Artifact
```

↓

### Step 3

Communicates with CodeDeploy Agent.

↓

### Step 4

Agent downloads application revision.

↓

### Step 5

Reads

```
appspec.yml
```

↓

### Step 6

Executes lifecycle hooks.

↓

### Step 7

Copies files.

↓

### Step 8

Runs startup scripts.

↓

### Step 9

Reports deployment status.

---

# 8. CodeDeploy Architecture

```
Developer

↓

CodePipeline

↓

CodeDeploy

↓

Deployment Group

↓

EC2 Instances

↓

CodeDeploy Agent

↓

Application Installed
```

---

# 9. Components of CodeDeploy

## 9.1 Application

Logical container.

Example

```
My Spring Boot App
```

One application can have multiple deployments.

---

## 9.2 Deployment Group

A deployment group tells CodeDeploy:

- Which EC2 instances
- Which ECS Service
- Which Auto Scaling Group

should receive deployment.

Example

```
Production

↓

EC2-1

EC2-2

EC2-3
```

---

## 9.3 Deployment

Actual deployment execution.

Example

Deployment #15

↓

Version 2.0

↓

Production

---

## 9.4 Revision

A revision is the package being deployed.

Usually

```
ZIP

JAR

WAR

Docker Image
```

---

# 10. CodeDeploy Agent

The Agent is the most important component.

Without Agent,

CodeDeploy **cannot communicate** with EC2.

Think of it as a messenger.

```
CodeDeploy

↓

Agent

↓

EC2
```

---

## 10.1 Why Agent is Required

AWS cannot simply copy files to your EC2.

Instead,

Agent continuously polls AWS.

```
Any Deployment?

↓

Yes

↓

Download

↓

Execute
```

---

## 10.2 Installing Agent (Amazon Linux)

```bash
sudo yum update -y

sudo yum install ruby wget -y

cd /home/ec2-user

wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install

chmod +x ./install

sudo ./install auto

sudo systemctl status codedeploy-agent
```

Expected Output

```
active (running)
```

---

## 10.3 Ubuntu Installation

```bash
sudo apt update

sudo apt install ruby-full wget -y

wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install

chmod +x install

sudo ./install auto

sudo systemctl status codedeploy-agent
```

---

## Verification

```bash
sudo systemctl status codedeploy-agent
```

Output

```
Active: active (running)
```

---

# 11. appspec.yml

This file tells CodeDeploy

- Where files should go
- Which scripts should execute
- Deployment lifecycle

Without this file,

Deployment fails.

---

## Basic Structure

```yaml
version: 0.0

os: linux

files:
  - source: /
    destination: /home/ec2-user/app

hooks:
  ApplicationStart:
    - location: scripts/start.sh
```

---

# 12. appspec.yml Sections

## version

Current version.

```
version: 0.0
```

---

## os

Operating system.

```
linux
```

---

## files

Copy application.

Example

```yaml
files:

- source: /

  destination: /home/ec2-user/app
```

Meaning

Everything

↓

Copy

↓

/home/ec2-user/app

---

## hooks

Runs scripts.

Example

```yaml
hooks:

  BeforeInstall:

  AfterInstall:

  ApplicationStart:

  ValidateService:
```

---

# 13. Lifecycle Hooks

Hooks are executed in sequence.

```
ApplicationStop

↓

BeforeInstall

↓

Install

↓

AfterInstall

↓

ApplicationStart

↓

ValidateService
```

---

## ApplicationStop

Stop old application.

Example

```bash
sudo systemctl stop springboot
```

---

## BeforeInstall

Cleanup old files.

```bash
rm -rf /home/ec2-user/app/*
```

---

## AfterInstall

Install dependencies.

```bash
chmod +x start.sh
```

---

## ApplicationStart

Start application.

```bash
java -jar app.jar
```

---

## ValidateService

Verify deployment.

Example

```bash
curl localhost:8080
```

If validation fails,

Deployment fails.

---

# 14. Example Project Structure

```
project/

├── appspec.yml

├── app.jar

└── scripts/

      start.sh

      stop.sh

      validate.sh
```

---

# 15. Practical 1 — Deploy Spring Boot on EC2

## Objective

Deploy a Spring Boot application automatically.

---

## Prerequisites

- EC2 instance
- IAM Role
- CodeDeploy Agent
- Security Group
- S3 Bucket (or CodePipeline)

---

## Step 1

Package application.

```
mvn clean package
```

Produces

```
target/app.jar
```

---

## Step 2

Create deployment bundle.

```
deployment.zip

│

├── app.jar

├── appspec.yml

└── scripts/
```

---

## Step 3

Upload bundle.

↓

Amazon S3

---

## Step 4

Create CodeDeploy Application.

Type

```
EC2/On-Premises
```

---

## Step 5

Create Deployment Group.

Select

- IAM Role
- EC2 Tags
- Deployment Config

---

## Step 6

Create Deployment.

Choose

```
deployment.zip
```

↓

Deploy

---

## Expected Output

```
Deployment Successful
```

Application accessible.

---

## Verification

```
systemctl status

Application Logs

Browser Test
```

---

# 16. Deployment to ECS

Unlike EC2,

CodeDeploy does NOT copy files.

Instead

```
New Docker Image

↓

Amazon ECR

↓

New ECS Task Definition

↓

New Task

↓

Traffic Shift

↓

Old Task Removed
```

Advantages

- Zero downtime
- Easy rollback
- Canary deployment
- Blue/Green deployment

---

# 17. Deployment to Auto Scaling Groups

Problem

Suppose Auto Scaling launches a new EC2 instance.

That instance has

```
No Application
```

CodeDeploy solves this.

```
New EC2

↓

CodeDeploy Agent

↓

Latest Deployment

↓

Application Installed
```

Every new server automatically gets the latest application version.

---

# 18. Redeployment

Need to deploy same version again?

Simply

```
Deployment History

↓

Select Revision

↓

Redeploy
```

Useful when

- Configuration changed
- Server replaced
- Auto Scaling launched new instances

---

# 19. Rollback

Rollback restores previous stable version.

Scenario

Version 1

↓

Working

↓

Deploy Version 2

↓

Application crashes

↓

Rollback

↓

Version 1 restored

Automatic rollback can be triggered by:

- Deployment failure
- CloudWatch Alarm
- Manual rollback

---

# 20. Common Errors

| Error | Reason | Solution |
|--------|--------|----------|
| Agent Offline | Agent stopped | Restart service |
| Missing appspec.yml | File not found | Add file to root |
| Script failed | Exit code ≠ 0 | Check logs |
| Permission denied | Script not executable | `chmod +x` |
| Deployment timeout | Long-running scripts | Optimize scripts |
| IAM AccessDenied | Missing role permissions | Update IAM policies |

---

# 21. Best Practices

- Always use deployment groups.
- Keep `appspec.yml` under version control.
- Use lifecycle hooks instead of manual SSH.
- Never hardcode secrets.
- Enable automatic rollback.
- Use Blue/Green deployments for production.
- Test in staging before production.
- Monitor deployments with CloudWatch.
- Use Application Load Balancer health checks.
- Keep deployment scripts idempotent (safe to run multiple times).

---

# 22. Interview Questions

1. What problem does AWS CodeDeploy solve?
2. Explain the difference between CodeBuild and CodeDeploy.
3. Why is the CodeDeploy Agent required?
4. What is the purpose of `appspec.yml`?
5. Explain each lifecycle hook.
6. How does CodeDeploy deploy to ECS?
7. What is a deployment group?
8. Difference between redeployment and rollback?
9. What happens if `ValidateService` fails?
10. How does CodeDeploy work with Auto Scaling Groups?

---

# 23. Summary

- **CodeDeploy** automates application deployment to EC2, ECS, and Auto Scaling Groups.
- The **CodeDeploy Agent** is mandatory for EC2 deployments because it receives deployment instructions and executes them on the instance.
- The **`appspec.yml`** file defines where application files are copied and which lifecycle hook scripts are executed.
- Lifecycle hooks (`ApplicationStop`, `BeforeInstall`, `AfterInstall`, `ApplicationStart`, and `ValidateService`) provide complete control over the deployment process.
- CodeDeploy supports **redeployment**, **automatic rollback**, and **Blue/Green deployments**, making deployments safer and reducing downtime.
- In production, combine CodeDeploy with **CodeBuild**, **CodePipeline**, **CloudWatch**, and **Application Load Balancers** to build reliable CI/CD pipelines.

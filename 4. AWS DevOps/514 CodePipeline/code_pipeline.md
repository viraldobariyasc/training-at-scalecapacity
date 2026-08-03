# 1. AWS CodePipeline

## 1.1 Learning Objectives

After completing this module, you should be able to:

- Understand Continuous Integration and Continuous Delivery.
- Explain the architecture of AWS CodePipeline.
- Understand every stage of a pipeline.
- Configure automated deployment workflows.
- Integrate CodePipeline with CodeBuild, CodeDeploy, ECS and Jenkins.
- Build complete CI/CD pipelines for production applications.

---

# 2. Why Do We Need CI/CD?

Imagine a developer fixes a bug.

Without CI/CD:

```
Developer

↓

Push Code

↓

SSH into Server

↓

Copy Files

↓

Restart Application

↓

Verify Logs
```

Now imagine you have

- 20 developers
- 10 deployments/day
- 5 environments

Manual deployment quickly becomes:

- Slow
- Error-prone
- Difficult to track
- Hard to rollback

---

## Continuous Integration (CI)

CI means integrating code changes frequently.

```
Developer

↓

Git Push

↓

Automatic Build

↓

Automatic Test
```

Benefits

- Detect bugs early
- Automated testing
- Faster feedback
- Consistent builds

---

## Continuous Delivery (CD)

Continuous Delivery means automatically preparing software for deployment.

```
Build

↓

Test

↓

Ready for Deployment
```

A human may still approve production deployment.

---

## Continuous Deployment

Continuous Deployment goes one step further.

```
Build

↓

Test

↓

Deploy Automatically
```

No manual approval.

Every successful build is deployed.

---

# 3. What is AWS CodePipeline?

AWS CodePipeline is a **fully managed CI/CD orchestration service**.

It automates the movement of code through different stages such as source, build, test, and deployment.

Unlike CodeBuild or CodeDeploy, CodePipeline **does not build or deploy by itself**. It coordinates other services.

---

## Real-World Analogy

Imagine a car manufacturing plant.

```
Raw Materials

↓

Assembly

↓

Quality Check

↓

Painting

↓

Delivery
```

Each department performs a specific task.

Similarly,

```
GitHub

↓

CodeBuild

↓

CodeDeploy

↓

Production
```

CodePipeline coordinates the entire workflow.

---

# 4. Why Use CodePipeline?

Without CodePipeline:

- Developers manually trigger builds
- Deployments require manual execution
- Difficult to maintain consistency
- No central pipeline view

With CodePipeline:

- Automatic execution
- Visual pipeline
- Integration with AWS services
- Easy rollback using deployment services
- Supports approval workflows

---

# 5. CodePipeline Architecture

```
Developer

↓

GitHub

↓

Source Stage

↓

Build Stage (CodeBuild)

↓

Test Stage

↓

Deploy Stage (CodeDeploy / ECS)

↓

Production
```

CodePipeline continuously monitors the source repository for changes.

---

# 6. Core Components

Every pipeline consists of:

```
Pipeline

↓

Stages

↓

Actions
```

---

## 6.1 Pipeline

A Pipeline is the complete CI/CD workflow.

Example

```
MyWebApplication Pipeline
```

It defines:

- Source
- Build
- Test
- Deploy

---

## 6.2 Stage

A Stage groups related actions.

Example:

```
Source Stage

↓

Build Stage

↓

Deploy Stage
```

Each stage can contain one or more actions.

---

## 6.3 Action

An Action performs one task.

Examples:

- Download source code
- Build application
- Run tests
- Deploy application
- Request approval

---

## 6.4 Transition

A Transition connects two stages.

```
Source

↓

Build

↓

Deploy
```

If a stage fails, the pipeline stops.

---

## 6.5 Execution

Every pipeline run is called an Execution.

```
Execution #1

Execution #2

Execution #3
```

AWS stores execution history for troubleshooting.

---

# 7. Source Stage

The Source stage retrieves the application code.

Supported sources:

- GitHub
- AWS CodeCommit
- Amazon S3
- Bitbucket
- GitHub Enterprise

Example:

```
Developer

↓

Git Push

↓

GitHub

↓

CodePipeline Triggered
```

CodePipeline downloads the latest source code and creates the first artifact.

---

## Source Artifact

An artifact is the output of a stage.

In the Source stage:

```
Git Repository

↓

Downloaded Source

↓

Source Artifact
```

This artifact is passed to the Build stage.

---

# 8. Build Stage

The Build stage typically uses AWS CodeBuild.

Responsibilities:

- Install dependencies
- Compile code
- Run tests
- Package application
- Build Docker images
- Generate reports

Flow:

```
Source Artifact

↓

CodeBuild

↓

Application Build

↓

Build Artifact
```

The Build Artifact may contain:

- JAR
- WAR
- ZIP
- Static Website Files
- Docker Image Metadata

---

## Example

Spring Boot

```
GitHub

↓

CodeBuild

↓

mvn clean package

↓

application.jar
```

---

# 9. Test Stage

Testing ensures the application works before deployment.

Tests may include:

- Unit Tests
- Integration Tests
- Security Scans
- Code Quality Checks

Example:

```
CodeBuild

↓

JUnit Tests

↓

Pass

↓

Deploy
```

If tests fail,

Pipeline execution stops.

---

## Best Practices

- Run tests automatically
- Fail pipeline immediately on test failures
- Separate unit and integration tests
- Generate test reports

---

# 10. Deploy Stage

The Deploy stage releases the application.

Supported deployment targets:

- Amazon EC2 (CodeDeploy)
- Amazon ECS
- Elastic Beanstalk
- AWS Lambda
- CloudFormation

Example:

```
Build Artifact

↓

CodeDeploy

↓

EC2

↓

Application Running
```

---

# 11. Invoke Stage

Invoke actions are used to call AWS Lambda functions.

Common use cases:

- Database migration
- Cache invalidation
- Slack notifications
- Custom validation
- API calls

Flow:

```
Deploy

↓

Lambda

↓

Custom Task

↓

Continue Pipeline
```

---

# 12. Manual Approval

Some deployments require human approval before production.

Example:

```
Build

↓

QA Deployment

↓

Manual Approval

↓

Production
```

Approver receives an SNS notification.

They can:

- Approve
- Reject

If rejected,

Pipeline stops.

---

# 13. Artifacts

Artifacts are files passed between stages.

```
Source Stage

↓

Source Artifact

↓

Build Stage

↓

Build Artifact

↓

Deploy Stage
```

Artifacts are usually stored in an S3 bucket managed by CodePipeline.

---

## Types of Artifacts

### Input Artifact

Received from previous stage.

Example:

```
Source Code
```

### Output Artifact

Generated by current stage.

Example:

```
application.jar

deployment.zip
```

---

# 14. Practical 1 – GitHub → CodeBuild → S3

## Objective

Automatically build a Java application and upload the artifact to Amazon S3.

### Steps

1. Create a GitHub repository.
2. Create a CodeBuild project.
3. Create an S3 bucket for artifacts.
4. Create a CodePipeline.
5. Configure Source = GitHub.
6. Configure Build = CodeBuild.
7. Configure Deploy = Amazon S3.
8. Push code to GitHub.

Expected Flow:

```
Git Push

↓

CodePipeline

↓

CodeBuild

↓

S3 Artifact
```

---

# 15. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Source stage failed | Invalid repository connection | Reconnect GitHub |
| Build failed | Buildspec error | Check CodeBuild logs |
| Artifact missing | Incorrect artifact path | Verify output artifact configuration |
| Deployment failed | CodeDeploy issue | Check deployment logs |
| Permission denied | IAM role missing | Update pipeline IAM role |

---

# 16. Best Practices

- Keep source, build, and deploy stages separate.
- Use CodeBuild only for builds.
- Use CodeDeploy for deployments.
- Store artifacts in encrypted S3 buckets.
- Enable CloudWatch Logs.
- Use Manual Approval before production.
- Implement rollback mechanisms.
- Use separate pipelines for Dev, QA, and Production.

---

# 17. Interview Questions (Part 1)

1. What is AWS CodePipeline?
2. Explain CI, Continuous Delivery, and Continuous Deployment.
3. What are Stages and Actions?
4. What is an Artifact?
5. Difference between Source Artifact and Build Artifact.
6. Why is CodeBuild used with CodePipeline?
7. Why is CodeDeploy used with CodePipeline?
8. What is Manual Approval?
9. What happens if a Build stage fails?
10. Explain the complete execution flow of CodePipeline.

---
---

# 18. Integration with Jenkins

Although AWS provides CodeBuild, many organizations already use Jenkins for building applications. CodePipeline can integrate with Jenkins instead of CodeBuild.

## Why Integrate Jenkins?

Many companies already have:

- Existing Jenkins jobs
- Shared Jenkins agents
- Custom plugins
- Complex build pipelines
- Large on-premise infrastructure

Instead of replacing Jenkins, CodePipeline orchestrates it.

### Architecture

```
Developer

↓

GitHub

↓

AWS CodePipeline

↓

Jenkins Build

↓

Artifact

↓

CodeDeploy

↓

Production
```

### Flow

1. Developer pushes code.
2. CodePipeline detects the change.
3. Jenkins job is triggered.
4. Jenkins builds the application.
5. Jenkins uploads artifacts.
6. CodePipeline continues with deployment.

### Advantages

- Reuse existing Jenkins pipelines.
- Gradual migration to AWS.
- Use Jenkins plugins while benefiting from CodePipeline orchestration.

---

# 19. Pipeline Execution Flow (End-to-End)

A typical production pipeline looks like this:

```
Developer

↓

Git Push

↓

GitHub

↓

Source Stage

↓

Build Stage

↓

Unit Tests

↓

Integration Tests

↓

Manual Approval

↓

Deploy to Staging

↓

Smoke Test

↓

Deploy to Production

↓

Monitoring
```

Each stage executes only if the previous stage succeeds.

---

# 20. Input & Output Artifacts

Artifacts are the files passed between pipeline stages.

### Example

```
GitHub Repository

↓

Source Artifact (ZIP)

↓

CodeBuild

↓

Build Artifact (JAR)

↓

CodeDeploy

↓

Running Application
```

### Source Artifact

Contains:

- Source code
- Configuration files
- buildspec.yml
- appspec.yml

### Build Artifact

Contains:

- JAR
- WAR
- Static website files
- Deployment bundle

Artifacts are usually stored in an S3 bucket managed by CodePipeline.

---

# 21. IAM Roles in CodePipeline

CodePipeline needs permissions to interact with other AWS services.

Example:

```
CodePipeline

↓

CodeBuild

↓

S3

↓

CodeDeploy

↓

CloudWatch
```

Typical permissions include:

- Read source from GitHub/CodeCommit
- Start CodeBuild projects
- Read/write S3 artifacts
- Trigger CodeDeploy deployments
- Invoke Lambda functions

**Best Practice:** Use a dedicated IAM service role with least-privilege permissions.

---

# 22. Pipeline Triggers

A pipeline can start automatically when:

- Code is pushed to GitHub
- CodeCommit receives a commit
- An EventBridge rule triggers it
- Another AWS service starts it manually

Example:

```
Developer

↓

git push

↓

Webhook

↓

CodePipeline Starts
```

This eliminates manual deployment steps.

---

# 23. Parallel Actions

A stage can run multiple actions simultaneously.

Example:

```
Build Stage

      |

-----------------------

|                     |

Frontend Build   Backend Build

-----------------------

      |

Deploy
```

Benefits:

- Faster execution
- Independent builds
- Better scalability

---

# 24. Variables

CodePipeline supports variables that can be passed between stages.

Examples:

- Commit ID
- Branch Name
- Build Number
- Repository Name

These variables can be used in CodeBuild or deployment scripts.

---

# 25. CloudWatch Integration

Every pipeline execution generates logs and events.

Monitor:

- Pipeline Success
- Pipeline Failure
- Stage Failure
- Build Duration

Example:

```
Pipeline Failed

↓

CloudWatch Alarm

↓

SNS Notification

↓

Email to DevOps Team
```

This helps quickly identify deployment issues.

---

# 26. EventBridge Integration

Amazon EventBridge can respond to pipeline events.

Example:

```
Pipeline Completed

↓

EventBridge

↓

Lambda

↓

Slack Notification
```

Other use cases:

- Trigger another pipeline
- Create Jira tickets
- Send Teams/Slack notifications
- Execute custom automation

---

# 27. Security Best Practices

- Enable encryption for S3 artifact bucket.
- Store secrets in AWS Secrets Manager or Parameter Store.
- Do not hardcode credentials in `buildspec.yml`.
- Use least-privilege IAM roles.
- Enable CloudTrail for auditing.
- Restrict production deployments with Manual Approval.
- Enable CloudWatch monitoring and alarms.

---

# 28. Multi-Environment Pipeline

Most production environments have separate deployment stages.

```
Developer

↓

Build

↓

Development

↓

QA

↓

Manual Approval

↓

Production
```

Advantages:

- Test before production
- Reduce deployment risks
- Easier rollback
- Better release control

---

# 29. Blue/Green Deployment

Instead of updating existing servers, a new environment is created.

```
Current Environment (Blue)

↓

Deploy New Version

↓

Green Environment

↓

Health Checks

↓

Traffic Shift

↓

Blue Removed
```

Benefits:

- Zero downtime
- Easy rollback
- Minimal user impact

CodePipeline typically performs this using **CodeDeploy** or **ECS Blue/Green Deployments**.

---

# 30. Complete Production Architecture

```
Developer

↓

GitHub

↓

AWS CodePipeline

↓

CodeBuild

↓

Unit Tests

↓

Security Scan

↓

Manual Approval

↓

CodeDeploy

↓

Auto Scaling Group

↓

Application Load Balancer

↓

Users
```

Supporting Services:

```
CloudWatch

↓

SNS

↓

Secrets Manager

↓

IAM

↓

Amazon S3 (Artifacts)
```

---

# 31. End-to-End Practical

## Objective

Deploy a Spring Boot application automatically to EC2.

### Prerequisites

- GitHub Repository
- Spring Boot Project
- CodeBuild Project
- CodeDeploy Application
- EC2 Instance with CodeDeploy Agent
- S3 Artifact Bucket
- IAM Roles

### Steps

1. Push code to GitHub.
2. CodePipeline detects the commit.
3. Source artifact is created.
4. CodeBuild compiles the application.
5. `application.jar` and `appspec.yml` are packaged.
6. Artifact is stored in S3.
7. CodeDeploy downloads the artifact.
8. CodeDeploy Agent deploys the application.
9. Validate deployment.
10. Application becomes available through the Load Balancer.

Expected Flow:

```
GitHub

↓

CodePipeline

↓

CodeBuild

↓

S3

↓

CodeDeploy

↓

EC2

↓

Application Running
```

---

# 32. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Source stage failed | Invalid GitHub connection | Reconnect repository |
| Build failed | Incorrect `buildspec.yml` | Review CodeBuild logs |
| Deploy failed | Invalid `appspec.yml` | Validate file structure |
| Approval timeout | No approver response | Approve or reject manually |
| Artifact not found | Wrong artifact path | Verify output artifact configuration |
| AccessDenied | Missing IAM permissions | Update service role |
| ECS deployment failed | Task definition issue | Verify task definition revision |
| Jenkins action failed | Jenkins unavailable | Check Jenkins server and credentials |

---

# 33. CodePipeline vs Jenkins

| Feature | AWS CodePipeline | Jenkins |
|---------|------------------|----------|
| Type | Managed AWS Service | Self-managed Automation Server |
| Infrastructure | Serverless | Requires Server/EC2 |
| Maintenance | AWS Managed | User Managed |
| Plugins | Limited | Thousands of Plugins |
| AWS Integration | Native | Requires Plugins |
| Scalability | Automatic | Manual |
| Pricing | Pay per active pipeline | Server + Maintenance Cost |

**When to use CodePipeline?**

- AWS-centric projects
- Minimal maintenance
- Native AWS integrations

**When to use Jenkins?**

- Existing Jenkins infrastructure
- Extensive plugin ecosystem
- Complex custom workflows

---

# 34. Best Practices

- Keep pipelines simple and modular.
- Separate Build and Deploy responsibilities.
- Use separate pipelines for Development, QA, and Production.
- Always enable logging and monitoring.
- Encrypt artifact buckets.
- Use Manual Approval before production deployment.
- Use immutable artifacts (do not modify after build).
- Integrate automated testing before deployment.
- Enable rollback strategies.
- Regularly review IAM permissions.

---

# 35. Interview Questions (Advanced)

1. What is AWS CodePipeline?
2. Explain the difference between CI, Continuous Delivery, and Continuous Deployment.
3. What are Stages and Actions?
4. What are Input and Output Artifacts?
5. How does CodePipeline integrate with CodeBuild?
6. How does CodePipeline integrate with CodeDeploy?
7. Explain Manual Approval.
8. How does Jenkins integrate with CodePipeline?
9. What are pipeline execution triggers?
10. What is Blue/Green deployment?
11. Explain the purpose of EventBridge in CodePipeline.
12. How do CloudWatch and SNS improve pipeline monitoring?
13. What IAM permissions does CodePipeline require?
14. How would you secure a production pipeline?
15. How would you design a multi-environment CI/CD pipeline?

---

# 36. Summary

- **AWS CodePipeline** is a fully managed CI/CD orchestration service that automates software release workflows.
- A pipeline is made up of **Stages**, and each stage contains one or more **Actions**.
- Common stages include **Source**, **Build**, **Test**, **Deploy**, **Invoke**, and **Manual Approval**.
- CodePipeline integrates natively with **GitHub, CodeBuild, CodeDeploy, ECS, Lambda, CloudWatch, EventBridge, and S3**.
- **Artifacts** are the files passed between stages and are typically stored in Amazon S3.
- Production pipelines commonly include automated testing, manual approvals, monitoring, and rollback mechanisms.
- Organizations with existing Jenkins infrastructure can integrate Jenkins with CodePipeline instead of replacing it.
- Following security best practices, using least-privilege IAM roles, and implementing multi-environment pipelines results in reliable and scalable CI/CD workflows.

---
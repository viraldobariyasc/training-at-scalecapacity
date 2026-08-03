# 1. Overview

## 1.1 What is an Artifact?

An **artifact** is any file produced during software development that is required later for deployment or reuse.

Examples:

- JAR
- WAR
- ZIP
- npm package
- Python package
- NuGet package 
- Docker Image (stored in ECR, not CodeArtifact)

Example:

```
Source Code

↓

Build

↓

application.jar

↓

Artifact
```

Artifacts are generally produced by **AWS CodeBuild** and consumed by **CodeDeploy**, ECS, EKS, or other applications.

---

# 2. What is AWS CodeArtifact?

AWS CodeArtifact is a **fully managed artifact repository** service.

It securely stores software packages and dependencies used by applications.

Instead of downloading packages directly from public repositories every time, developers retrieve them from CodeArtifact.

```
Developer

↓

CodeArtifact

↓

Maven Central
```

The first request downloads the dependency from Maven Central.

Future requests are served directly from CodeArtifact.

---

## Why was CodeArtifact introduced?

Without CodeArtifact:

```
Developer

↓

Internet

↓

Maven Central
```

Problems:

- Slow downloads
- Internet dependency
- No version control
- Public package outages
- Security concerns

With CodeArtifact:

```
Developer

↓

AWS CodeArtifact

↓

Cached Package
```

Benefits:

- Faster builds
- Central package management
- Improved security
- Better version control
- Supports private packages

---

# 3. Where CodeArtifact Fits in CI/CD

```
Developer

↓

GitHub

↓

CodeBuild

↓

CodeArtifact

↓

Application Build

↓

CodeDeploy
```

CodeArtifact is mainly used during the **Build** stage.

---

# 4. CodeArtifact Architecture

```
                Domain

                  │

        ┌─────────┴─────────┐

        │                   │

 Repository A         Repository B

        │                   │

        └───────┬───────────┘

                │

        External Connection

                │

          Maven Central
```

---

# 5. CodeArtifact Domain

A **Domain** is the highest-level container.

Think of it as a company.

Example:

```
Company Domain

│

├── Java Repository

├── Node Repository

├── Python Repository
```

### Advantages

- Shared authentication
- Shared storage
- Central permission management
- Cross-repository package sharing

---

# 6. Repository

A repository stores packages.

Example:

```
java-repository

↓

Spring Boot

JUnit

Hibernate
```

Another repository:

```
node-repository

↓

React

Express

Axios
```

Repositories are usually created:

- Per language
- Per project
- Per environment
- Per team

---

# 7. Resource Policy

Resource Policies determine **who can access** repositories or domains.

Example:

```
Developer

↓

Read Packages

✔ Allowed

CI/CD Pipeline

↓

Publish Packages

✔ Allowed

Anonymous User

↓

Delete Packages

❌ Denied
```

Policies are written in IAM JSON format.

Example:

```json
{
  "Effect":"Allow",
  "Action":[
    "codeartifact:ReadFromRepository"
  ],
  "Resource":"*"
}
```

Best Practice:

Always follow the **Least Privilege Principle**.

---

# 8. Upstream Repositories

Suppose Repository A does not contain a dependency.

Instead of failing,

it checks Repository B.

```
Repository A

↓

Repository B

↓

Package Found

↓

Returned to Developer
```

Benefits:

- Avoid duplicate packages
- Share packages between teams
- Easier maintenance

---

# 9. External Connections

External Connections connect CodeArtifact to public package repositories.

Supported examples:

- Maven Central
- npm Registry
- PyPI
- NuGet Gallery

Flow:

```
Developer

↓

CodeArtifact

↓

Maven Central

↓

Package Cached

↓

Future Downloads

↓

Served Directly
```

This significantly reduces download time.

---

# 10. Retention Hierarchy

Hierarchy inside CodeArtifact:

```
Domain

↓

Repository

↓

Package

↓

Package Version
```

Example:

```
company-domain

↓

java-repository

↓

spring-boot

↓

3.5.0

↓

3.4.8

↓

3.4.7
```

Retention allows organizations to:

- Keep required versions
- Remove obsolete versions
- Reduce storage costs

---

# 11. Supported Package Formats

| Package Manager | Language |
|-----------------|----------|
| Maven | Java |
| npm | JavaScript |
| pip | Python |
| NuGet | .NET |
| Swift | Swift |
| Cargo | Rust |
| Generic | Any Files |

---

# 12. Practical – Create a Maven Repository

## Objective

Store Java dependencies securely using CodeArtifact.

### Step 1

Open

AWS Console

↓

CodeArtifact

### Step 2

Create Domain

Example:

```
company-domain
```

### Step 3

Create Repository

```
java-repository
```

Associate it with the created domain.

### Step 4

Configure External Connection

Select:

```
Maven Central
```

### Step 5

Authenticate Maven

```bash
aws codeartifact login \
--tool mvn \
--domain company-domain \
--repository java-repository
```

Expected Output:

```
Successfully configured Maven.
```

### Step 6

Run Build

```bash
mvn clean package
```

Dependencies are downloaded through CodeArtifact.

---

# 13. Integration with CodeBuild

```
GitHub

↓

AWS CodeBuild

↓

CodeArtifact

↓

Dependencies Downloaded

↓

Application Built
```

This avoids downloading packages directly from the internet every build.

---

# 14. CodeArtifact vs Amazon ECR

| Feature | CodeArtifact | Amazon ECR |
|----------|--------------|------------|
| Stores | Software Packages | Docker Images |
| Used By | Maven, npm, pip, NuGet | Docker, ECS, EKS |
| Example | Spring Boot Dependency | Docker Image |
| Primary Purpose | Dependency Management | Container Registry |

---

# 15. Best Practices

- Create separate repositories for each package manager.
- Use Domains to organize repositories.
- Configure upstream repositories instead of duplicating packages.
- Grant least-privilege IAM permissions.
- Enable CloudTrail for auditing.
- Remove unused package versions.
- Store private company libraries in CodeArtifact.
- Integrate CodeArtifact with CodeBuild for faster builds.

---

# 16. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| AccessDenied | Missing IAM Permission | Update IAM Policy |
| Authentication Failed | Login Token Expired | Run `aws codeartifact login` again |
| Repository Not Found | Incorrect Repository Name | Verify Repository |
| Package Not Found | Missing External Connection | Configure Maven Central |
| Unauthorized | Invalid Credentials | Re-authenticate |

---

# 17. Interview Questions

1. What is AWS CodeArtifact?
2. What is an artifact?
3. Difference between CodeArtifact and ECR?
4. What is a Domain?
5. What is a Repository?
6. Explain Resource Policies.
7. Explain Upstream Repository.
8. What are External Connections?
9. How does CodeArtifact improve build performance?
10. How does CodeArtifact integrate with CodeBuild?

---

# 18. Summary

- AWS CodeArtifact is a managed artifact repository for software packages.
- It supports Maven, npm, pip, NuGet, Swift, Cargo, and Generic packages.
- Domains organize repositories and enable shared authentication and storage.
- Resource Policies control repository access.
- Upstream Repositories and External Connections simplify dependency management and caching.
- CodeArtifact integrates naturally with CodeBuild to improve build speed, security, and reliability.
- Docker images are stored in Amazon ECR, while application dependencies are stored in CodeArtifact.

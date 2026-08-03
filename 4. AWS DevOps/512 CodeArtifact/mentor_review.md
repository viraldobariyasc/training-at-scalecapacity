# CodeArtifact.md

# To Learn

- Overview
- Resource Policy
- Upstream Repositories
- External Connections to External Public Repositories
- Retention Hierarchy
- Code Artifacts Domains

# Extra Topics

- What is an Artifact?
- Supported Package Formats (Maven, npm, pip, NuGet, Swift, Cargo)
- Repository vs Domain
- Repository Endpoints
- Authentication using AWS CLI
- Package Versioning
- Cross-Account Access
- Integration with AWS CodeBuild
- Integration with AWS CodePipeline
- Security Best Practices
- Common Errors & Troubleshooting
- CodeArtifact vs Amazon ECR

# Practical Tasks

## Practical 1: Create a CodeArtifact Domain

**Objective**

Create a CodeArtifact Domain to organize repositories.

---

## Practical 2: Create a Repository

**Objective**

Create a Maven repository inside the domain.

---

## Practical 3: Configure External Connection

**Objective**

Connect the repository to Maven Central and verify package downloads.

---

## Practical 4: Configure Upstream Repository

**Objective**

Configure one repository to fetch packages from another repository.

---

## Practical 5: Configure Maven Authentication

**Objective**

Authenticate Maven using AWS CLI and download dependencies through CodeArtifact.

---

## Practical 6: Publish a Package

**Objective**

Publish your own package into CodeArtifact and consume it from another project.

---

## Practical 7: Configure Resource Policy

**Objective**

Allow read/write access using IAM and Resource Policies.

---

## Practical 8: Integrate with CodeBuild

**Objective**

Configure CodeBuild to download dependencies from CodeArtifact during builds.

# Interview Topics

- What problem does CodeArtifact solve?
- Difference between CodeArtifact and Amazon ECR.
- What is a Domain?
- What is a Repository?
- Explain Upstream Repository.
- Explain External Connections.
- What is Dependency Caching?
- What is Resource Policy?
- How does CodeArtifact integrate with CodeBuild?
- Which package managers are supported?
- How do you authenticate Maven or npm with CodeArtifact?

# Sources

- ChatGPT
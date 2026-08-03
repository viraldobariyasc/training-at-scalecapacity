# 1. Overview

Continuous Deployment (CD) is the process of automatically deploying an application after it has been successfully built and tested.

With Jenkins, deployment becomes part of the CI/CD pipeline, reducing manual work and ensuring faster, more reliable releases.

---

# 2. CI vs Continuous Delivery vs Continuous Deployment

| Practice | Description |
|----------|-------------|
| Continuous Integration (CI) | Automatically build and test code after every commit. |
| Continuous Delivery | Code is always ready for deployment, but deployment may require manual approval. |
| Continuous Deployment | Every successful build is automatically deployed without manual intervention. |

Flow:

```
Developer

↓

Git Push

↓

Jenkins

↓

Build

↓

Test

↓

Deploy

↓

Users
```

---

# 3. Jenkins Deployment Workflow

A typical deployment pipeline:

```
GitHub

↓

Jenkins

↓

Clone Repository

↓

Build

↓

Run Tests

↓

Package Artifact

↓

Deploy

↓

Verify Application
```

Jenkins coordinates each step automatically.

---

# 4. Common Deployment Methods

Jenkins can deploy applications using different approaches.

| Method | Use Case |
|---------|----------|
| SSH | Deploy to Linux servers or EC2 |
| Docker | Run updated containers |
| Tomcat | Deploy Java WAR applications |
| Kubernetes | Deploy containerized applications |
| AWS Services | ECS, Elastic Beanstalk, Lambda, etc. |

---

# 5. Deploying via SSH

One of the simplest deployment methods.

Flow:

```
Jenkins

↓

SSH Connection

↓

EC2 Server

↓

Copy Artifact

↓

Restart Application
```

Typical commands:

```bash
scp target/app.jar ubuntu@<EC2-IP>:/home/ubuntu/

ssh ubuntu@<EC2-IP>

sudo systemctl restart springboot-app
```

SSH keys should be stored securely using **Jenkins Credentials**.

---

# 6. Deploying to Docker

Instead of copying application files, Jenkins builds and runs a Docker image.

Example workflow:

```
GitHub

↓

Jenkins

↓

docker build

↓

docker push

↓

docker run
```

Example commands:

```bash
docker build -t spring-app .

docker run -d -p 8080:8080 spring-app
```

---

# 7. Deploying to Apache Tomcat

For Java web applications packaged as `.war` files.

Workflow:

```
GitHub

↓

Jenkins

↓

Build WAR

↓

Copy to Tomcat webapps/

↓

Tomcat Deploys Application
```

---

# 8. Deploying to AWS EC2

Example architecture:

```
GitHub

↓

Jenkins

↓

Build

↓

application.jar

↓

EC2

↓

Spring Boot Application
```

Requirements:

- EC2 instance
- Java installed
- SSH access
- Jenkins credentials
- Security Group allowing SSH

---

# 9. Build Artifacts

A build artifact is the output generated after a successful build.

Examples:

- `.jar`
- `.war`
- `.zip`
- Docker image

Artifacts can be:

- Archived in Jenkins
- Uploaded to Nexus/Artifactory
- Copied to deployment servers

---

# 10. Rollback Basics

Sometimes deployments fail.

Rollback means restoring the previous working version.

Example:

```
Version 1.0

↓

Deploy Version 2.0

↓

Failure

↓

Rollback to Version 1.0
```

Keeping previous artifacts makes rollback easier.

---

# 11. Practical

## Objective

Deploy a Spring Boot application to an EC2 instance using Jenkins.

### Prerequisites

- Jenkins installed
- Git configured
- Maven configured
- EC2 instance running
- Java installed on EC2
- SSH key added to Jenkins Credentials

### Step 1

Create a Freestyle or Pipeline job.

---

### Step 2

Clone the GitHub repository.

---

### Step 3

Build the application.

```bash
mvn clean package
```

---

### Step 4

Archive the generated JAR file.

---

### Step 5

Copy the JAR to EC2.

Example:

```bash
scp target/app.jar ubuntu@<EC2-IP>:/home/ubuntu/
```

---

### Step 6

Restart the application.

```bash
ssh ubuntu@<EC2-IP>

sudo systemctl restart springboot-app
```

---

### Step 7

Verification

Open:

```
http://<EC2-Public-IP>:8080
```

Application should be accessible.

---

# 12. Best Practices

- Always run tests before deployment.
- Store SSH keys in Jenkins Credentials.
- Archive build artifacts.
- Use versioned artifacts for easy rollback.
- Separate development and production deployments.
- Automate deployment verification when possible.

---

# 13. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| SSH authentication failed | Incorrect SSH key | Update Jenkins credentials |
| Permission denied | Insufficient server permissions | Check user permissions |
| Build artifact not found | Build failed | Verify build success before deployment |
| Application not starting | Port conflict or configuration issue | Check application logs |
| Deployment succeeded but app inaccessible | Firewall/Security Group | Verify inbound rules and application port |

---

# 14. Interview Questions

1. What is Continuous Deployment?
2. Difference between Continuous Delivery and Continuous Deployment.
3. How does Jenkins automate deployments?
4. What are build artifacts?
5. Why are SSH credentials stored in Jenkins?
6. How would you deploy a Spring Boot application to EC2 using Jenkins?
7. What is rollback?
8. How can Jenkins deploy Docker applications?
9. What checks should be performed before deployment?
10. Why is artifact versioning important?

---

# 15. Summary

- Continuous Deployment automatically releases applications after successful builds and tests.
- Jenkins can deploy applications to servers, Docker containers, Tomcat, Kubernetes, and AWS services.
- Common deployment methods include SSH, Docker, and cloud integrations.
- Build artifacts should be archived and versioned for traceability and rollback.
- Secure credential management, automated testing, and rollback planning are essential for reliable deployments.
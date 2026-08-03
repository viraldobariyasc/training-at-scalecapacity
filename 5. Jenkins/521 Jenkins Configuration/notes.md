# 1. Overview

After installing Jenkins, the next step is configuring it for real CI/CD projects.

Configuration includes:

- Installing required tools
- Managing credentials
- Configuring agents
- Installing plugins
- Setting global options
- Securing Jenkins

Most configuration is available under:

```
Dashboard

↓

Manage Jenkins
```

---

# 2. Manage Jenkins

The **Manage Jenkins** page is the administration panel.

Important options include:

- Tools
- Plugins
- Credentials
- Nodes
- System
- Security
- System Information
- Logs

Think of it as the "Settings" page of Jenkins.

---

# 3. Global Tool Configuration

Navigate to:

```
Manage Jenkins

↓

Tools
```

Configure tools that Jenkins jobs will use.

Common tools:

| Tool | Purpose |
|------|---------|
| JDK | Java builds |
| Git | Clone repositories |
| Maven | Build Java projects |
| Gradle | Gradle projects |
| Docker | Build container images |

Example:

```
JDK

Name: JDK17

Path:
/usr/lib/jvm/java-17-openjdk-amd64
```

Similarly configure Git and Maven if not automatically detected.

---

# 4. Jenkins Credentials

Credentials allow Jenkins to securely access external services.

Examples:

- GitHub
- AWS
- Docker Hub
- SSH Servers
- Kubernetes

Never hardcode passwords inside jobs.

---

## Types of Credentials

| Type | Example |
|------|---------|
| Username & Password | GitHub Login |
| SSH Username with Private Key | EC2 Login |
| Secret Text | GitHub Token |
| Secret File | SSL Certificate |
| AWS Credentials | AWS Access Key |

---

## Adding Credentials

Navigate to:

```
Manage Jenkins

↓

Credentials

↓

Global

↓

Add Credentials
```

Provide:

- Kind
- Username
- Password/Key
- ID
- Description

---

# 5. Jenkins Nodes (Agents)

By default, Jenkins has one built-in node (controller).

For larger workloads, add agents.

Example:

```
Controller

│

├── Linux Agent

├── Windows Agent

└── Docker Agent
```

Advantages:

- Parallel builds
- Better performance
- Isolated environments

---

# 6. Environment Variables

Global environment variables can be shared across jobs.

Examples:

```
JAVA_HOME

MAVEN_HOME

DOCKER_HOST

AWS_REGION
```

They eliminate repetitive configuration in every job.

---

# 7. Plugin Management

Plugins extend Jenkins functionality.

Navigate to:

```
Manage Jenkins

↓

Plugins
```

Useful plugins:

| Plugin | Purpose |
|---------|---------|
| Git | Git Integration |
| Pipeline | Jenkins Pipeline |
| Docker | Docker Support |
| SSH Agent | Remote Deployment |
| Blue Ocean | Improved UI |
| AWS Steps | AWS Integration |

Keep plugins updated but test updates before production.

---

# 8. Global Security

Navigate to:

```
Manage Jenkins

↓

Security
```

Recommended settings:

- Enable Authentication
- Matrix or Role-Based Authorization
- Disable anonymous access
- Enable CSRF Protection
- Use HTTPS in production

---

# 9. Backup and Restore

The most important directory is:

```bash
/var/lib/jenkins
```

Backup this directory regularly.

It contains:

- Jobs
- Plugins
- Credentials
- Build history
- User configurations

Simple backup example:

```bash
sudo tar -czf jenkins-backup.tar.gz /var/lib/jenkins
```

---

# 10. Practical

## Objective

Configure Jenkins for Java project builds.

### Step 1

Configure:

- JDK
- Git
- Maven

### Step 2

Install plugins:

- Git
- Pipeline
- Docker
- Blue Ocean

### Step 3

Create GitHub credentials.

### Step 4

Verify Git installation.

### Step 5

Create a test Freestyle Job and confirm Git, Java, and Maven are detected correctly.

---

# 11. Best Practices

- Store secrets only in Jenkins Credentials.
- Use agents for builds instead of the controller.
- Keep plugins updated.
- Remove unused plugins.
- Use descriptive names for tools and credentials.
- Backup `JENKINS_HOME` regularly.
- Grant minimum required permissions.

---

# 12. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Git not found | Git not installed/configured | Configure Git under Global Tools |
| Maven not found | Maven missing | Configure Maven |
| Authentication failed | Wrong credentials | Update Jenkins Credentials |
| Agent offline | Connectivity issue | Verify SSH/network configuration |
| Plugin dependency error | Incompatible plugin versions | Update required plugins |

---

# 13. Interview Questions

1. What is Global Tool Configuration?
2. Why are Jenkins Credentials used?
3. Name different types of Jenkins credentials.
4. What is the purpose of Jenkins Agents?
5. Why should passwords not be stored inside jobs?
6. How do you configure Git in Jenkins?
7. What is the purpose of plugins?
8. What should be backed up in Jenkins?

---

# 14. Summary

- Jenkins Configuration prepares Jenkins for real-world CI/CD pipelines.
- Configure tools like JDK, Git, Maven, and Docker before creating jobs.
- Store sensitive information using Jenkins Credentials.
- Use agents to improve scalability and performance.
- Install only necessary plugins and keep them updated.
- Secure Jenkins with authentication, authorization, HTTPS, and regular backups.
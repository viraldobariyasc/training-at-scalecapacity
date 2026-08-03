# 1. Overview

Jenkins is designed to be lightweight. Most of its advanced features are provided through **plugins**.

A plugin is an extension that adds new functionality without modifying Jenkins itself.

Examples:

- Connect to GitHub
- Build Docker images
- Deploy to AWS
- Send Slack notifications
- Execute Maven builds

Without plugins, Jenkins provides only basic functionality.

---

# 2. What are Jenkins Plugins?

Plugins allow Jenkins to integrate with external tools and services.

```
                Jenkins

      ┌─────────┼─────────┐
      │         │         │
    GitHub    Docker     AWS
      │         │         │
      └─────────┼─────────┘
             Plugins
```

Plugins are downloaded from the Jenkins Update Center.

---

# 3. Plugin Manager

Navigate to:

```
Manage Jenkins

↓

Plugins
```

From here you can:

- Install new plugins
- Update existing plugins
- Disable plugins
- Remove plugins
- View installed plugins

---

# 4. Common Jenkins Plugins

| Plugin | Purpose |
|---------|---------|
| Git | Clone Git repositories |
| GitHub | GitHub integration and webhooks |
| Pipeline | Pipeline as Code (Jenkinsfile) |
| Maven Integration | Build Maven projects |
| Docker | Build and manage Docker containers |
| SSH Agent | Connect to remote servers |
| Blue Ocean | Modern Jenkins UI |
| AWS Steps | Interact with AWS services |
| Credentials Binding | Securely use secrets in jobs |

---

# 5. Git & GitHub Integration

Git integration enables Jenkins to:

- Clone repositories
- Checkout branches
- Build code after commits

Workflow:

```
Developer

↓

Git Push

↓

GitHub

↓

Webhook

↓

Jenkins

↓

Build
```

### Configuration Steps

1. Install **Git** and **GitHub** plugins.
2. Configure Git under **Manage Jenkins → Tools**.
3. Add GitHub credentials under **Manage Jenkins → Credentials**.
4. Use the repository URL in your Jenkins job.

---

# 6. Docker Integration

The Docker plugin enables Jenkins to work with Docker.

Common tasks:

- Build Docker images
- Push images to Docker Hub or Amazon ECR
- Run containers
- Remove old containers

Example commands executed by Jenkins:

```bash
docker build -t springboot-app .

docker tag springboot-app:latest myrepo/springboot-app:latest

docker push myrepo/springboot-app:latest
```

**Note:** Jenkins user must have permission to access the Docker daemon.

---

# 7. Maven Integration

The Maven Integration plugin simplifies Java builds.

Configure Maven under:

```
Manage Jenkins

↓

Tools

↓

Maven Installations
```

Build command:

```bash
mvn clean package
```

Output:

```
target/application.jar
```

---

# 8. AWS Integration

Jenkins can integrate with AWS using plugins.

Common AWS plugins:

| Plugin | Purpose |
|---------|---------|
| AWS Steps | Execute AWS operations |
| Pipeline: AWS | AWS pipeline steps |
| Amazon EC2 | Manage EC2 agents |
| Amazon ECR | Authenticate and push Docker images |

Example use cases:

- Upload files to S3
- Push images to ECR
- Deploy using CodeDeploy
- Launch EC2 instances

---

# 9. Blue Ocean

Blue Ocean is an alternative Jenkins UI focused on Pipelines.

Features:

- Modern interface
- Visual pipeline stages
- Easier debugging
- Better pipeline visualization

It is especially useful when working with Jenkins Pipelines.

---

# 10. Practical

## Objective

Integrate Jenkins with GitHub and Docker.

### Step 1: Install Plugins

Go to:

```
Manage Jenkins

↓

Plugins

↓

Available Plugins
```

Install:

- Git
- GitHub
- Docker
- Pipeline
- Blue Ocean

Restart Jenkins if required.

---

### Step 2: Configure Git

```
Manage Jenkins

↓

Tools

↓

Git
```

Specify the Git installation path if not detected automatically.

---

### Step 3: Configure GitHub Credentials

Navigate to:

```
Manage Jenkins

↓

Credentials
```

Add:

- Username/Password **or**
- Personal Access Token (recommended)

---

### Step 4: Verify Integration

Create a Freestyle project.

Provide:

- GitHub Repository URL
- Credentials

Click **Build Now**.

Verify that Jenkins successfully clones the repository.

---

# 11. Best Practices

- Install only required plugins.
- Keep plugins updated.
- Test plugin updates before production.
- Remove unused plugins.
- Use official and well-maintained plugins.
- Store credentials securely using Jenkins Credentials.
- Review plugin compatibility before upgrading Jenkins.

---

# 12. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Plugin installation failed | Network or proxy issue | Check internet connectivity |
| Git not detected | Git not installed | Configure Git in Global Tools |
| Authentication failed | Incorrect credentials | Update Jenkins credentials |
| Docker permission denied | Jenkins user not in docker group | Add Jenkins user to `docker` group |
| Plugin dependency error | Missing required plugin | Install required dependencies |

---

# 13. Interview Questions

1. What are Jenkins Plugins?
2. Why are plugins required?
3. What is the Plugin Manager?
4. Name some commonly used Jenkins plugins.
5. How does Jenkins integrate with GitHub?
6. Why is the Git plugin required?
7. How can Jenkins work with Docker?
8. What AWS plugins are commonly used?
9. What is Blue Ocean?
10. What are the best practices for managing Jenkins plugins?

---

# 14. Summary

- Plugins extend Jenkins functionality and enable integration with external tools.
- Common integrations include GitHub, Docker, Maven, AWS, and Blue Ocean.
- Plugins are managed through **Manage Jenkins → Plugins**.
- Secure integrations require proper credential management.
- Keep plugins updated, remove unused plugins, and use only trusted plugins to maintain a secure and stable Jenkins environment.
# 1. Overview

## 1.1 What is Jenkins?

Jenkins is an **open-source automation server** used to automate software development tasks such as:

- Building applications
- Running tests
- Deploying applications
- Automating repetitive tasks

Jenkins is one of the most popular **Continuous Integration (CI)** and **Continuous Delivery (CD)** tools used in DevOps.

Instead of manually building and deploying code, Jenkins performs these tasks automatically whenever changes are pushed to a repository.

---

## 1.2 Why Do We Need Jenkins?

Imagine a developer updates a Spring Boot application.

Without Jenkins:

```
Developer

↓

Push Code

↓

Login to Server

↓

Run Maven Build

↓

Copy Files

↓

Restart Application

↓

Verify Application
```

This process is:

- Time-consuming
- Repetitive
- Error-prone

With Jenkins:

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
```

Everything happens automatically.

---

# 2. Continuous Integration (CI)

Continuous Integration means developers frequently merge their code into a shared repository.

Each commit automatically triggers:

- Source code checkout
- Build
- Testing
- Code quality checks

Benefits:

- Detects bugs early
- Reduces manual work
- Faster feedback
- Consistent builds

---

# 3. Jenkins Architecture

Jenkins follows a **Controller-Agent** architecture.

```
          Jenkins Controller

                 │

      ┌──────────┴──────────┐

      │                     │

 Linux Agent          Windows Agent
```

---

## 3.1 Controller

The Controller is the main Jenkins server.

Responsibilities:

- Manages jobs
- Schedules builds
- Stores configurations
- Manages plugins
- Displays the Jenkins UI
- Assigns work to agents

---

## 3.2 Agent

Agents execute the actual jobs.

Examples:

- Build Java applications
- Build Docker images
- Execute tests
- Deploy applications

Using multiple agents allows Jenkins to execute jobs in parallel.

---

# 4. Jenkins Components

| Component | Description |
|-----------|-------------|
| Controller | Central management server |
| Agent | Executes jobs |
| Job | A single automation task |
| Build | One execution of a job |
| Workspace | Directory where project files are stored during execution |
| Plugin | Adds additional functionality |
| Pipeline | Complete CI/CD workflow |

---

# 5. Jenkins Home Directory

Jenkins stores all its configuration and data in:

```bash
/var/lib/jenkins
```

It contains:

- Jobs
- Plugins
- User accounts
- Build history
- Credentials
- Logs

Backing up this directory is important because it contains almost all Jenkins configuration.

---

# 6. Jenkins Plugins

Plugins extend Jenkins functionality.

Common plugins include:

| Plugin | Purpose |
|---------|---------|
| Git | Connect to Git repositories |
| Pipeline | Create CI/CD pipelines |
| Maven Integration | Build Java projects |
| Docker | Build Docker images |
| SSH Agent | Deploy to remote servers |
| Blue Ocean | Modern Jenkins UI |

Plugins make Jenkins highly customizable.

---

# 7. Jenkins Installation (Ubuntu)

## Objective

Install Jenkins and access its web interface.

### Prerequisites

- Ubuntu 22.04 or later
- Internet connection
- Sudo privileges
- Java 17+

### Step 1: Install Java

```bash
sudo apt update
sudo apt install fontconfig openjdk-17-jdk -y
```

Verify:

```bash
java -version
```

---

### Step 2: Add Jenkins Repository

```bash
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null
```

```bash
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null
```

---

### Step 3: Install Jenkins

```bash
sudo apt update
sudo apt install jenkins -y
```

---

### Step 4: Start Jenkins

```bash
sudo systemctl enable jenkins
sudo systemctl start jenkins
```

Verify:

```bash
sudo systemctl status jenkins
```

Expected output:

```
Active: active (running)
```

---

### Step 5: Access Jenkins

Open your browser:

```
http://<SERVER-IP>:8080
```

---

### Step 6: Retrieve Initial Password

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Paste the password into the Jenkins setup page.

---

### Step 7: Install Suggested Plugins

Choose:

```
Install Suggested Plugins
```

Jenkins automatically installs commonly used plugins.

---

### Step 8: Create Admin User

Provide:

- Username
- Password
- Full Name
- Email Address

Log in with the new administrator account.

---

# 8. Configure Global Tools

Navigate to:

```
Manage Jenkins

↓

Tools
```

Configure:

- JDK
- Git
- Maven

These tools are required by build jobs and pipelines.

---

# 9. Jenkins Dashboard

After login, the dashboard provides access to:

- New Item (Create Jobs)
- Build History
- Manage Jenkins
- Credentials
- Nodes
- Plugins
- System Logs

Take time to explore each section before creating jobs.

---

# 10. Jenkins vs AWS CodeBuild

| Feature | Jenkins | AWS CodeBuild |
|---------|----------|---------------|
| Type | Self-managed | Fully Managed |
| Infrastructure | User-managed | AWS-managed |
| Plugins | Thousands available | Limited |
| Maintenance | Required | No maintenance |
| Scalability | Manual (Agents) | Automatic |
| Best For | Custom CI/CD workflows | AWS-native build automation |

---

# 11. Best Practices

- Use the **LTS (Long-Term Support)** version for production.
- Keep Jenkins and plugins updated.
- Store passwords in Jenkins Credentials instead of scripts.
- Execute builds on agents rather than the controller.
- Regularly back up the `JENKINS_HOME` directory.
- Restrict access using authentication and role-based authorization.
- Use HTTPS in production environments.

---

# 12. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Jenkins service not starting | Java missing or incorrect version | Install Java 17+ |
| Port 8080 already in use | Another service is using the port | Change Jenkins port or stop the conflicting service |
| Unable to access UI | Firewall or security group blocking port 8080 | Allow inbound traffic on port 8080 |
| Initial password not found | Wrong file path | Verify `/var/lib/jenkins/secrets/initialAdminPassword` |
| Plugin installation failed | Internet/proxy issues | Check network connectivity and proxy settings |

---

# 13. Interview Questions

1. What is Jenkins?
2. Why is Jenkins used in DevOps?
3. What is Continuous Integration?
4. Explain the Jenkins Controller-Agent architecture.
5. What are Jenkins Plugins?
6. What is JENKINS_HOME?
7. Why does Jenkins require Java?
8. How is Jenkins different from AWS CodeBuild?
9. Why should builds run on agents instead of the controller?
10. How do you secure a Jenkins installation?

---

# 14. Summary

- Jenkins is an open-source automation server used for CI/CD.
- It automates build, test, and deployment tasks.
- Jenkins follows a Controller-Agent architecture to improve scalability.
- Plugins allow Jenkins to integrate with Git, Docker, Maven, AWS, and many other tools.
- Initial setup involves installing Java, Jenkins, plugins, and configuring global tools.
- Jenkins is highly flexible and is commonly used for custom CI/CD pipelines, while AWS CodeBuild is a managed alternative for build automation.
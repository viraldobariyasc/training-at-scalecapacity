# 1. Overview

A **Build Job** is the basic unit of work in Jenkins.

A job defines **what Jenkins should do**, such as:

- Clone source code
- Compile the application
- Run tests
- Package the application
- Deploy the application

Whenever a job runs, Jenkins creates a **Build**.

---

# 2. Types of Jenkins Jobs

Jenkins supports multiple job types.

| Job Type | Purpose |
|-----------|---------|
| Freestyle Project | General-purpose jobs for beginners |
| Pipeline | CI/CD as Code using Jenkinsfile |
| Multibranch Pipeline | Build multiple Git branches automatically |
| Folder | Organize jobs |
| External Job | Monitor external processes |

For beginners, the **Freestyle Project** is the easiest to understand.

---

# 3. Freestyle Project

A Freestyle Project allows you to configure a build using the Jenkins UI.

Typical configuration includes:

- Source Code Management
- Build Triggers
- Build Environment
- Build Steps
- Post-build Actions

Example:

```
GitHub

↓

Clone Repository

↓

Run Maven Build

↓

Archive Artifact
```

---

# 4. Build Workflow

A typical Jenkins build follows this sequence:

```
Build Trigger

↓

Clone Source Code

↓

Build

↓

Run Tests

↓

Package Application

↓

Archive Artifacts

↓

Build Result
```

---

# 5. Build Workspace

Every job has its own **Workspace**.

The workspace contains:

- Source code
- Downloaded dependencies
- Generated files
- Build outputs

Example location:

```bash
/var/lib/jenkins/workspace/MyProject
```

---

# 6. Build Triggers

Build triggers decide **when** a job starts.

Common triggers:

| Trigger | Description |
|----------|-------------|
| Build Now | Manual execution |
| Poll SCM | Periodically checks Git for changes |
| GitHub Webhook | GitHub notifies Jenkins immediately |
| Build after another project | Chain multiple jobs |
| Scheduled (CRON) | Run at a specific time |

### Poll SCM

Jenkins checks the repository at regular intervals.

Example:

```
H/5 * * * *
```

Checks every 5 minutes.

### GitHub Webhook

```
Developer

↓

Git Push

↓

GitHub

↓

Webhook

↓

Jenkins Build
```

Webhook is preferred because it starts builds immediately without polling.

---

# 7. Build Steps

A Build Step tells Jenkins what commands to execute.

Examples:

- Execute Shell
- Invoke Maven
- Gradle Build
- Windows Batch Command

Example shell command:

```bash
echo "Starting Build"

mvn clean package

echo "Build Completed"
```

---

# 8. Post-build Actions

Executed after a successful build.

Examples:

- Archive artifacts
- Send email notifications
- Trigger another job
- Publish test reports

Example:

```
Build Success

↓

Archive application.jar

↓

Email Team
```

---

# 9. Console Output

Every build generates logs.

Navigate to:

```
Job

↓

Build #

↓

Console Output
```

Example:

```
Cloning repository...

Running Maven...

BUILD SUCCESS
```

Console Output is the first place to check when troubleshooting build failures.

---

# 10. Parameterized Builds

Parameterized Builds allow users to provide input before starting a build.

Example parameters:

- Branch Name
- Environment (Dev/QA/Prod)
- Application Version

Example:

```
Environment = QA

↓

Build Starts

↓

Deploy to QA
```

---

# 11. Practical

## Objective

Create a Freestyle job that builds a Java Maven project.

### Step 1

Navigate to:

```
Dashboard

↓

New Item

↓

Freestyle Project
```

Enter:

```
Job Name

↓

java-demo-build
```

---

### Step 2

Configure Source Code Management.

Choose:

```
Git

↓

Repository URL

↓

Credentials (if required)
```

---

### Step 3

Configure Build Trigger.

Select either:

- Build Now (manual)
- GitHub Webhook
- Poll SCM

---

### Step 4

Add Build Step.

Choose:

```
Invoke Top-Level Maven Targets
```

Goals:

```bash
clean package
```

---

### Step 5

Save the job.

Click:

```
Build Now
```

---

### Step 6

Verify Build

A successful build appears as:

```
#1

SUCCESS
```

Click the build number and view **Console Output**.

Expected output:

```
[INFO] BUILD SUCCESS
```

---

# 12. Best Practices

- Keep one responsibility per job.
- Use Git Webhooks instead of Poll SCM whenever possible.
- Archive important build artifacts.
- Use meaningful job names.
- Keep build logs for troubleshooting.
- Clean workspaces periodically.
- Move to Pipeline jobs for production CI/CD.

---

# 13. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Git clone failed | Wrong repository URL or credentials | Verify Git URL and credentials |
| Maven not found | Maven not configured | Configure Maven in Global Tools |
| Build failed | Compilation error | Review Console Output |
| Workspace permission denied | Incorrect file permissions | Fix workspace ownership |
| Webhook not triggering | Incorrect webhook configuration | Verify GitHub webhook URL |

---

# 14. Interview Questions

1. What is a Jenkins Build Job?
2. What is a Freestyle Project?
3. What is the purpose of a Workspace?
4. Explain Build Triggers.
5. Difference between Poll SCM and GitHub Webhooks.
6. What is Console Output?
7. What are Post-build Actions?
8. What is a Parameterized Build?
9. Where do Jenkins build artifacts come from?
10. Why are Pipeline jobs preferred over Freestyle jobs?

---

# 15. Summary

- A Build Job defines the tasks Jenkins performs to build an application.
- Freestyle Projects are ideal for learning basic Jenkins concepts.
- Build Triggers automate job execution using webhooks, polling, or schedules.
- Build Steps execute commands such as compiling or packaging applications.
- Post-build Actions handle tasks like archiving artifacts and sending notifications.
- Console Output is essential for monitoring and debugging builds.
- As projects grow, Freestyle jobs are often replaced by Jenkins Pipelines for better scalability and maintainability.
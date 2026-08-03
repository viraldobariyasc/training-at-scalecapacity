# 1. Overview

Jenkins Schema refers to the overall workflow and architecture of how Jenkins executes a build from start to finish.

Instead of focusing on databases, it explains **how different Jenkins components interact** during a CI/CD process.

---

# 2. Jenkins Workflow

A typical Jenkins workflow is:

```
Developer

↓

Git Push

↓

GitHub

↓

Webhook

↓

Jenkins Controller

↓

Allocate Agent

↓

Clone Repository

↓

Build

↓

Test

↓

Package

↓

Archive Artifacts

↓

Deploy (Optional)

↓

Build Result
```

---

# 3. Jenkins Architecture

```
             Jenkins Controller
                    │
      ┌─────────────┼─────────────┐
      │                           │
 Linux Agent                 Windows Agent
      │                           │
 Build Java                Build .NET
```

### Controller Responsibilities

- Schedule jobs
- Manage plugins
- Store configurations
- Monitor agents
- Display dashboard

### Agent Responsibilities

- Execute builds
- Run tests
- Create artifacts
- Deploy applications

---

# 4. Build Lifecycle

Every Jenkins build follows these stages:

```
Job Trigger

↓

Workspace Created

↓

Clone Source Code

↓

Execute Build Steps

↓

Run Tests

↓

Generate Artifacts

↓

Post-build Actions

↓

Save Logs

↓

Build Completed
```

Each execution receives a unique build number.

Example:

```
Build #1

Build #2

Build #3
```

---

# 5. Job Execution Flow

When **Build Now** is clicked:

1. Jenkins schedules the job.
2. A suitable agent is selected.
3. Workspace is prepared.
4. Source code is downloaded.
5. Build commands execute.
6. Console logs are generated.
7. Artifacts are archived.
8. Build status is updated.

Possible build results:

- SUCCESS
- FAILURE
- ABORTED
- UNSTABLE

---

# 6. Workspace

Each job gets its own workspace.

Example:

```bash
/var/lib/jenkins/workspace/my-java-project
```

Workspace contains:

- Source code
- Dependencies
- Temporary files
- Build outputs

---

# 7. Build Artifacts

Artifacts are files generated after a successful build.

Examples:

- JAR
- WAR
- ZIP
- HTML reports

Artifacts can be archived inside Jenkins or uploaded to external repositories.

---

# 8. Console Output

Every build produces execution logs.

Example:

```
Started by GitHub push

Cloning repository...

Running Maven...

BUILD SUCCESS

Finished: SUCCESS
```

Console Output is the primary tool for troubleshooting failed builds.

---

# 9. Practical

## Objective

Understand the complete Jenkins execution flow.

### Steps

1. Create a Freestyle Project.
2. Connect it to a GitHub repository.
3. Add a simple shell build step:

```bash
echo "Building Project"

mvn clean package
```

4. Click **Build Now**.
5. Observe:
   - Build Queue
   - Console Output
   - Workspace
   - Build History
   - Generated Artifact

---

# 10. Best Practices

- Use separate agents for builds.
- Archive important artifacts.
- Review Console Output for failures.
- Keep workspaces clean.
- Monitor build history regularly.
- Use Pipelines for complex workflows.

---

# 11. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Build stuck in queue | No available executor | Increase executors or add agents |
| Workspace issue | Permission or disk problem | Check ownership and free space |
| Artifact missing | Incorrect archive configuration | Verify artifact path |
| Build failed | Compilation or test error | Review Console Output |

---

# 12. Interview Questions

1. Explain the Jenkins execution flow.
2. What happens internally when a build starts?
3. What is a Jenkins Workspace?
4. What are Build Artifacts?
5. What is the role of the Controller?
6. What is the role of an Agent?
7. What are the possible build statuses?
8. Where do you check build logs?

---

# 13. Summary

- Jenkins Schema describes how a build flows through the Jenkins system.
- The Controller schedules jobs, while Agents execute them.
- Every build creates a workspace, executes build steps, generates artifacts, and stores logs.
- Understanding this workflow helps in troubleshooting and designing efficient CI/CD pipelines.
# AWS CodeDeploy - Real Deployment Flow

## Prerequisites

Before a deployment starts:

- EC2 instances are running.
- CodeDeploy Agent is installed and running on each EC2.
- Application revision (ZIP/TAR) is stored in **Amazon S3**, **GitHub**, or provided by **CodePipeline**.
- The revision contains an `appspec.yml` file.
- A CodeDeploy **Application** and **Deployment Group** are already configured.

---

## Deployment Flow

```text
Developer / CodePipeline
          │
          ▼
1. Create Deployment
          │
          ▼
2. CodeDeploy identifies the application revision
   (S3 / GitHub / CodePipeline Artifact)
          │
          ▼
3. CodeDeploy notifies the CodeDeploy Agent
   on all target EC2 instances
          │
          ▼
4. Agent downloads the application revision
   to the EC2 instance
          │
          ▼
5. Agent extracts the package and reads appspec.yml
          │
          ▼
6. Executes lifecycle hooks in order
   (ApplicationStop → BeforeInstall →
    AfterInstall → ApplicationStart →
    ValidateService)
          │
          ▼
7. Copies application files to the destination
   specified in appspec.yml
          │
          ▼
8. Starts the application and validates it
          │
          ▼
9. Agent reports Success/Failure to CodeDeploy
          │
          ▼
Deployment Completed
```

---

## What `appspec.yml` Does

`appspec.yml` tells the CodeDeploy Agent:

- Where to copy application files.
- Which lifecycle hook scripts to execute.
- The order in which those scripts should run.

Without `appspec.yml`, CodeDeploy cannot deploy the application.

---

## Key Points

- **CodeDeploy Service** orchestrates the deployment.
- **CodeDeploy Agent** performs the deployment on the EC2 instance.
- **Application revision** is downloaded **by the agent**, not manually.
- **Lifecycle hooks** are executed based on `appspec.yml`.
- If any lifecycle hook exits with a non-zero status, the deployment is marked **Failed**.
- After completion, the agent reports the deployment status back to the CodeDeploy service.

---

## Real Example

```
Express App v1 running on EC2
        │
        ▼
Upload express-v2.zip to S3
        │
        ▼
Create Deployment
        │
        ▼
Agent downloads ZIP
        │
        ▼
Reads appspec.yml
        │
        ▼
Stops old app
        │
        ▼
Copies new files
        │
        ▼
Runs npm install (if configured)
        │
        ▼
Starts Express App v2
        │
        ▼
Health check passes
        │
        ▼
Deployment Succeeded
```
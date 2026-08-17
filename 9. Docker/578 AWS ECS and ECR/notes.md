# AWS ECS and ECR Deep Dive

## 1. ECR and ECS Overview

Amazon ECR and Amazon ECS solve two different problems.

- **ECR** → Stores Docker/container images.
- **ECS** → Runs and manages containers.

Simple analogy:

```text
ECR = Warehouse for Docker Images

ECS = System that runs those images
```

Typical flow:

```text
Developer
    |
    | docker build
    v
Docker Image
    |
    | docker push
    v
Amazon ECR
    |
    | ECS pulls image
    v
Amazon ECS
    |
    v
Running Container
```

ECS can run containers using AWS Fargate or other supported capacity options. Fargate allows ECS to run containers without you managing the underlying servers. [AWS ECS documentation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html)

---

# 2. Amazon ECR

## 2.1 What is ECR?

**Amazon Elastic Container Registry (ECR)** is a managed container image registry.

It stores Docker/OCI images that can later be pulled by ECS, EKS, EC2, CI/CD systems, etc.

Example:

```text
ECR Repository
      |
      +-- myapp:1.0
      +-- myapp:1.1
      +-- myapp:2.0
```

---

## 2.2 ECR Repository

A repository stores images for a particular application.

Example:

```text
my-backend
    |
    +-- 1.0
    +-- 1.1
    +-- 1.2
```

Create a repository:

```bash
aws ecr create-repository \
  --repository-name my-backend
```

List repositories:

```bash
aws ecr describe-repositories
```

---

## 2.3 Push Docker Image to ECR

### Step 1: Login to ECR

```bash
aws ecr get-login-password --region <region> | \
docker login \
--username AWS \
--password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
```

### Step 2: Build Image

```bash
docker build -t my-backend .
```

### Step 3: Tag Image

```bash
docker tag my-backend:latest \
<account-id>.dkr.ecr.<region>.amazonaws.com/my-backend:1.0
```

### Step 4: Push

```bash
docker push \
<account-id>.dkr.ecr.<region>.amazonaws.com/my-backend:1.0
```

ECR requires authentication and appropriate IAM permissions for pushing images. [AWS ECR documentation](https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-push.html)

---

# 3. Amazon ECS

## 3.1 What is ECS?

**Amazon Elastic Container Service (ECS)** is a managed container orchestration service.

It manages:

- Running containers
- Desired number of containers
- Deployments
- Networking
- Scaling
- Health checks
- Service replacement

```text
                ECS
                 |
        +--------+--------+
        |                 |
      Service           Task
        |                 |
    3 replicas       Container(s)
```

---

# 4. ECS Important Components

The most important ECS concepts are:

```text
Cluster
   |
   +--> Service
          |
          +--> Task
                 |
                 +--> Container
                        |
                        +--> ECR Image
```

## 4.1 Cluster

A cluster is a logical grouping of ECS workloads.

Example:

```text
production-cluster
       |
       +-- backend-service
       +-- frontend-service
```

---

## 4.2 Task Definition

A **task definition is the blueprint for your application**.

It defines things such as:

- Container image
- CPU
- Memory
- Port mappings
- Environment variables
- Logging
- IAM roles
- Volumes
- Networking configuration

AWS describes the task definition as the blueprint for the application. [AWS ECS task definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html)

Example:

```json
{
  "family": "backend",
  "networkMode": "awsvpc",
  "containerDefinitions": [
    {
      "name": "backend",
      "image": "123456789.dkr.ecr.ap-south-1.amazonaws.com/backend:1.0",
      "cpu": 256,
      "memory": 512,
      "portMappings": [
        {
          "containerPort": 8080
        }
      ]
    }
  ]
}
```

---

## 4.3 Task

A **task is a running instance of a task definition**.

```text
Task Definition
      |
      +----> Task 1
      |
      +----> Task 2
      |
      +----> Task 3
```

If the task definition says:

```text
Image = backend:1.0
CPU   = 256
Memory = 512 MB
```

each task launched from it follows that configuration.

---

## 4.4 Service

An ECS service maintains the desired number of tasks.

Example:

```text
Desired Count = 3

Task 1 → Running
Task 2 → Running
Task 3 → Running
```

If Task 2 crashes:

```text
Task 1 → Running
Task 2 → Stopped
Task 3 → Running
```

ECS attempts to launch another task so the service returns to:

```text
3 Running Tasks
```

This desired-state behavior is a key ECS concept. [AWS ECS task definitions](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html)

---

# 5. ECS Fargate

Fargate allows ECS to run containers without managing EC2 servers.

With EC2:

```text
You manage:
EC2
OS
Patching
Capacity
        |
        v
      ECS
        |
        v
   Containers
```

With Fargate:

```text
AWS manages infrastructure
        |
        v
      ECS
        |
        v
   Containers
```

You mainly specify:

- CPU
- Memory
- Networking
- Container image
- IAM configuration

Fargate requires valid task-level CPU and memory combinations. [AWS Fargate documentation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/fargate-tasks-services.html)

---

# 6. ECS Networking

For Fargate, `awsvpc` networking is used.

Each task gets its own network interface and private IP address.

```text
VPC
 |
 +-- Private Subnet
       |
       +-- ECS Task
             |
             +-- ENI
             +-- Private IP
```

A common production architecture is:

```text
Internet
    |
    v
   ALB
    |
    v
Private Subnet
    |
    +--> ECS Task
    +--> ECS Task
```

The ECS task security group should normally allow traffic from the ALB security group rather than from the entire internet.

---

# 7. ECS Task Role vs Execution Role

This is a **very important interview topic**.

## 7.1 Execution Role

The **task execution role** is used by ECS/Fargate infrastructure for actions such as:

- Pulling private images from ECR
- Sending logs to CloudWatch Logs

Example:

```text
ECS/Fargate
    |
    +--> Pull image from ECR
    |
    +--> Send logs to CloudWatch
```

## 7.2 Task Role

The **task role** gives permissions to the application running inside the container.

Example:

```text
Spring Boot Container
        |
        | AWS SDK
        v
       S3
```

The application might need:

```text
s3:GetObject
```

That permission belongs to the **task role**.

Simple rule:

```text
Execution Role → ECS infrastructure

Task Role      → Application inside container
```

---

# 8. ECS Deployment Flow

A typical deployment looks like:

```text
Developer
    |
    v
Git
    |
    v
CI/CD
    |
    v
docker build
    |
    v
Docker Image
    |
    v
ECR
    |
    v
New Task Definition Revision
    |
    v
ECS Service
    |
    v
New Tasks
    |
    v
ALB
    |
    v
Users
```

When you deploy a new image, you generally create/update a task definition revision and update the ECS service to use it. ECS services use the specified task-definition family/revision. [AWS ECS service documentation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/service_definition_parameters.html)

---

# 9. Practical: Deploy Docker Image to ECS Fargate

## 9.1 Objective

Deploy a Dockerized application using:

```text
Docker
   ↓
ECR
   ↓
ECS Fargate
   ↓
ALB
```

## 9.2 Prerequisites

- AWS CLI configured
- Docker installed
- AWS IAM permissions
- VPC
- Subnets
- Security groups
- ECR repository
- ECS cluster

---

## 9.3 Step 1: Create ECR Repository

```bash
aws ecr create-repository \
  --repository-name my-backend \
  --region ap-south-1
```

---

## 9.4 Step 2: Build Docker Image

```bash
docker build -t my-backend .
```

Verify:

```bash
docker images
```

---

## 9.5 Step 3: Login to ECR

```bash
aws ecr get-login-password \
--region ap-south-1 | \
docker login \
--username AWS \
--password-stdin \
<account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

Expected:

```text
Login Succeeded
```

---

## 9.6 Step 4: Tag Image

```bash
docker tag my-backend:latest \
<account-id>.dkr.ecr.ap-south-1.amazonaws.com/my-backend:1.0
```

---

## 9.7 Step 5: Push Image

```bash
docker push \
<account-id>.dkr.ecr.ap-south-1.amazonaws.com/my-backend:1.0
```

Verify:

```bash
aws ecr describe-images \
--repository-name my-backend \
--region ap-south-1
```

---

## 9.8 Step 6: Create ECS Cluster

```bash
aws ecs create-cluster \
--cluster-name my-cluster \
--region ap-south-1
```

---

## 9.9 Step 7: Create Task Definition

Important fields:

```text
family
executionRoleArn
taskRoleArn
networkMode
cpu
memory
containerDefinitions
```

The container definition references the ECR image:

```text
<account-id>.dkr.ecr.ap-south-1.amazonaws.com/my-backend:1.0
```

Register it:

```bash
aws ecs register-task-definition \
--cli-input-json file://task-definition.json
```

---

## 9.10 Step 8: Create ECS Service

The service specifies:

- Cluster
- Task definition
- Desired count
- Fargate launch type
- Subnets
- Security groups

Conceptually:

```text
ECS Service
    |
    +-- Task 1
    +-- Task 2
    +-- Task 3
```

AWS's Fargate workflow is essentially cluster → task definition → service → running tasks. [AWS ECS Fargate tutorial](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/getting-started-fargate.html)

---

# 10. Important ECS Commands

List clusters:

```bash
aws ecs list-clusters
```

List services:

```bash
aws ecs list-services \
--cluster my-cluster
```

List tasks:

```bash
aws ecs list-tasks \
--cluster my-cluster
```

Describe service:

```bash
aws ecs describe-services \
--cluster my-cluster \
--services my-service
```

Describe task:

```bash
aws ecs describe-tasks \
--cluster my-cluster \
--tasks <task-id>
```

---

# 11. Troubleshooting ECS

When a task doesn't start, check:

```text
ECS Service
     |
     +--> Service Events
     |
     +--> Task Stopped Reason
     |
     +--> CloudWatch Logs
     |
     +--> ECR Image
     |
     +--> IAM Role
     |
     +--> Security Group
     |
     +--> Subnet / Route
```

Common problems:

### ECR Image Pull Failure

Check:

- Image URI
- Image tag
- Execution role
- Network connectivity

### Container Exits Immediately

Check:

- Application logs
- Docker CMD/ENTRYPOINT
- Environment variables
- Application configuration

### Health Check Failure

Check:

- Application port
- Container port
- ALB target group
- Security groups
- Health-check path

### Task Stuck in Pending

Check:

- Subnet connectivity
- IAM permissions
- ECR access
- CPU/memory
- Security groups

---

# 12. ECR vs ECS

| ECR | ECS |
|---|---|
| Stores images | Runs containers |
| Container registry | Container orchestration |
| `docker push` | Deploy/service |
| `docker pull` | Runs tasks |
| Similar to Docker Hub | Similar to orchestration platform |

Easy way to remember:

```text
ECR → Where is my image?

ECS → How should my container run?
```

---

# 13. ECS vs EKS

| ECS | EKS |
|---|---|
| AWS-native container orchestration | Managed Kubernetes |
| Simpler AWS integration | Kubernetes ecosystem |
| Easier to operate | More complex |
| Uses ECS concepts | Uses Kubernetes concepts |
| Good AWS-focused choice | Good when Kubernetes is required |

---

# 14. Best Practices

- Use immutable/versioned image tags instead of relying only on `latest`.
- Use private ECR repositories for private applications.
- Follow least privilege for ECS IAM roles.
- Keep ECS tasks in private subnets when appropriate.
- Put ALB in public subnets and application tasks behind it.
- Send container logs to CloudWatch.
- Use health checks.
- Use separate task and execution roles.
- Use ECS service desired count for high availability.
- Scan container images for vulnerabilities.

---

# 15. Interview Questions

1. What is the difference between ECS and ECR?
2. What is an ECS cluster?
3. What is a task definition?
4. Difference between task and service?
5. What happens when an ECS service task crashes?
6. What is ECS Fargate?
7. What is the difference between task role and execution role?
8. How does ECS pull an image from ECR?
9. How does an ECS task communicate with an ALB?
10. Why do Fargate tasks use `awsvpc` networking?
11. How would you troubleshoot an ECS task stuck in `PENDING`?
12. What happens when you deploy a new ECS task-definition revision?
13. ECS vs EKS?
14. Why should production images not depend only on the `latest` tag?

---

# 16. Summary

The most important architecture to remember is:

```text
                    Internet
                       |
                       v
                      ALB
                       |
                +------+------+
                |             |
             ECS Task      ECS Task
                |             |
                +------+------+
                       |
                  ECR Image
                       |
                       v
                 ECR Repository
```

And the deployment flow:

```text
Code
  |
  v
Docker Build
  |
  v
Docker Image
  |
  | docker push
  v
ECR
  |
  v
ECS Task Definition
  |
  v
ECS Service
  |
  v
Fargate Tasks
  |
  v
ALB → Users
```

Remember these four concepts first:

```text
ECR           → Stores images
ECS Cluster   → Groups ECS workloads
Task Definition → Blueprint
ECS Service   → Maintains desired running tasks
```

Once these are clear, ECS becomes much easier to understand.
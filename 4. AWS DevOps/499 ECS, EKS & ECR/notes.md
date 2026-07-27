# ECS-EKS-notes.md

# 1. Container Orchestration on AWS

## 1.1 Why Container Orchestration?

Docker solved one problem:

> "How do I package my application?"

It did **not** solve:

- Where should containers run?
- How are they restarted?
- How do we scale them?
- How do we load balance?
- How do we update applications with zero downtime?
- How do multiple containers communicate?

Container orchestration platforms solve these problems.

AWS provides two managed orchestrators:

| Service | Based On |
|----------|----------|
| ECS | AWS Native |
| EKS | Kubernetes |

---

# 2. Docker vs Virtual Machines

## 2.1 Why Virtual Machines Came First

Traditionally applications ran directly on servers.

Problem:

If App A needed Java 8 and App B needed Java 17, conflicts occurred.

VMs solved this by virtualizing hardware.

```
Physical Server
│
├── Hypervisor
│
├── VM 1
│     OS
│     Java 8
│     App A
│
└── VM 2
      OS
      Java 17
      App B
```

Each VM has:

- Full operating system
- Own kernel
- Memory
- Storage

Result:

- Heavy
- Slow boot
- Large images
- More resource usage

---

## 2.2 Docker Containers

Docker virtualizes at the OS level.

```
Physical Server

Host OS

Docker Engine

Container 1
App

Container 2
App

Container 3
App
```

Containers share the Host Kernel.

Advantages:

- Starts in seconds
- Lightweight
- Portable
- Better utilization
- Easy scaling

---

## 2.3 Comparison

| Feature | Virtual Machine | Docker |
|----------|----------------|---------|
| Boot Time | Minutes | Seconds |
| Size | GBs | MBs |
| OS Required | Full OS | Shared Host OS |
| Performance | Lower | Near Native |
| Resource Usage | High | Low |
| Portability | Moderate | Excellent |

---

## 2.4 Real Production Example

Netflix may run:

- thousands of containers
- hundreds of EC2 instances

Running thousands of VMs would be extremely expensive.

---

# 3. Amazon ECS

## 3.1 What is ECS?

Amazon Elastic Container Service is AWS's managed container orchestrator.

AWS manages scheduling.

You manage:

- Docker Images
- CPU
- Memory
- Networking
- Scaling

---

## 3.2 ECS Components

```
Cluster
│
├── Service
│      │
│      ├── Task
│      │      ├── Container
│      │      └── Container
│      │
│      └── Task
│
└── Service
```

Hierarchy:

Cluster

↓

Service

↓

Task

↓

Container

---

## 3.3 Cluster

Logical grouping of compute resources.

Can contain:

- EC2
- Fargate
- Both

---

## 3.4 Task

Running instance of Task Definition.

Equivalent to:

Docker container(s)

---

## 3.5 Service

Maintains desired number of tasks.

Example:

Desired Count = 3

If one task crashes,

ECS automatically launches another.

---

# 4. ECS Task Definitions

## 4.1 What is Task Definition?

Blueprint of your application.

Contains:

- Docker Image
- CPU
- Memory
- Ports
- Environment Variables
- IAM Role
- Logging
- Volumes
- Secrets

Example:

```
Task Definition

Container:
  nginx:latest

CPU:
512

Memory:
1024

Port:
80
```

---

## 4.2 Revisions

Every update creates:

Revision 1

↓

Revision 2

↓

Revision 3

Services can be updated to latest revision.

Production advantage:

Easy rollback.

---

# 5. ECS Launch Types

## 5.1 EC2 Launch Type

AWS manages ECS.

You manage EC2.

Responsibilities:

- Instance patching
- Scaling EC2
- Capacity
- AMI updates

Architecture

```
ALB

↓

EC2

↓

Docker

↓

Containers
```

Pros

- Cheapest
- GPU supported
- Full control

Cons

- Infrastructure management

---

## 5.2 Fargate

Serverless containers.

AWS manages everything.

```
ALB

↓

Fargate

↓

Containers
```

Pros

- No servers
- Easy
- Secure
- Pay per usage

Cons

- Higher cost
- Less customization

---

## 5.3 EC2 vs Fargate

| Feature | EC2 | Fargate |
|----------|------|----------|
| Manage EC2 | Yes | No |
| Serverless | No | Yes |
| Cost | Lower | Higher |
| Custom AMIs | Yes | No |
| GPU | Yes | Limited |
| Simplicity | Medium | Excellent |

---

# 6. ECS Load Balancer Integration

ALB is most common.

```
Internet

↓

ALB

↓

Target Group

↓

ECS Tasks
```

Benefits:

- Health Checks
- SSL
- Path Routing
- Host Routing

Production:

Never expose ECS tasks directly.

Always use ALB.

---

# 7. ECS Data Volumes

Containers are ephemeral.

Deleting container means data disappears.

Volumes solve this.

Types:

## 7.1 Bind Mount

Uses EC2 disk.

Only EC2 launch type.

---

## 7.2 Docker Volume

Managed by Docker.

---

## 7.3 Amazon EFS

Shared storage.

```
Task A

↓

EFS

↑

Task B
```

Multiple tasks can share files.

Common use:

WordPress uploads.

---

# 8. ECS IAM Roles

Two important roles.

## 8.1 Task Execution Role

Used by ECS Agent.

Examples:

- Pull image from ECR
- Send logs to CloudWatch
- Fetch Secrets

---

## 8.2 Task Role

Used by application.

Example:

Spring Boot app

↓

Reads S3

↓

Writes DynamoDB

Task Role permissions apply.

Golden Rule:

Never use Execution Role inside application.

---

# 9. ECS Service Auto Scaling

Automatically adjusts number of Tasks.

Example

Minimum = 2

Maximum = 10

Policy:

CPU > 70%

↓

Launch more tasks

CPU < 30%

↓

Remove tasks

Metrics:

- CPU
- Memory
- ALB Request Count

---

Production Best Practice:

Always configure

Minimum Tasks >= 2

to avoid downtime.

---

# 10. Amazon ECR

Elastic Container Registry.

Private Docker Registry.

Workflow

```
Developer

↓

Docker Build

↓

Docker Push

↓

Amazon ECR

↓

ECS Pulls Image
```

Useful Commands

```bash
aws ecr get-login-password

docker build -t app .

docker tag app:latest <account>.dkr.ecr.<region>.amazonaws.com/app:latest

docker push <account>.dkr.ecr.<region>.amazonaws.com/app:latest
```

Features

- Private repositories
- Image scanning
- Encryption
- Lifecycle policies
- Cross Region replication

---

# 11. Amazon EKS

Managed Kubernetes Service.

AWS manages:

Control Plane.

You manage:

Worker Nodes.

```
AWS Managed Control Plane

↓

Worker Nodes

↓

Pods

↓

Containers
```

---

## 11.1 Why EKS?

Use when:

- Kubernetes skills already exist
- Hybrid cloud
- Vendor neutrality
- CNCF ecosystem

---

# 12. EKS Node Types

## 12.1 Managed Node Group

AWS manages:

- Launch Templates
- ASG
- Updates

Recommended.

---

## 12.2 Self Managed

You manage everything.

Rarely recommended.

---

## 12.3 AWS Fargate

Pods run without EC2.

Good for:

- Small workloads
- Microservices
- Batch Jobs

---

Comparison

| Type | EC2 Managed | Self Managed | Fargate |
|-------|-------------|--------------|----------|
| Patch Nodes | AWS | User | AWS |
| Scale Nodes | AWS | User | AWS |
| Control | Medium | Full | Least |

---

# 13. EKS Data Volumes

Pods are temporary.

Persistent data requires volumes.

Options

## 13.1 EBS CSI Driver

Single AZ storage.

Fast.

Best for databases.

---

## 13.2 EFS CSI Driver

Multi-node shared storage.

Good for:

- Shared uploads
- CMS
- ML datasets

---

## 13.3 FSx

Windows or Lustre workloads.

---

# 14. ECS vs EKS

| Feature | ECS | EKS |
|----------|-----|-----|
| Complexity | Low | High |
| Kubernetes | No | Yes |
| Learning Curve | Easy | Steep |
| AWS Integration | Excellent | Excellent |
| Vendor Lock-in | Higher | Lower |
| Best For | AWS workloads | Kubernetes portability |

---

# 15. Practical 1 – Deploy an Application on ECS

## 15.1 Objective

Deploy a Dockerized web application using ECS Fargate with an Application Load Balancer.

## 15.2 Prerequisites

- Docker installed
- AWS CLI configured
- IAM permissions
- ECR repository
- VPC with public/private subnets

## 15.3 Steps

1. Build Docker image.
2. Create an ECR repository.
3. Push the image to ECR.
4. Create an ECS cluster.
5. Register a task definition.
6. Create an ECS service using Fargate.
7. Attach an ALB and target group.
8. Access the application using the ALB DNS name.

> 📷 Screenshot: ECR repository after image push.  
> 📷 Screenshot: ECS cluster overview.  
> 📷 Screenshot: Task definition details.  
> 📷 Screenshot: ECS service with running tasks.  
> 📷 Screenshot: ALB target group showing healthy targets.

## 15.4 Expected Output

- ECS service reaches desired task count.
- ALB target health is **Healthy**.
- Opening the ALB DNS name displays the web application.

## 15.5 Verification

- Verify task status is `RUNNING`.
- Check CloudWatch logs.
- Confirm the target group health checks pass.
- Access the application through the ALB.

## 15.6 Common Errors

| Error | Cause | Resolution |
|-------|-------|------------|
| CannotPullContainerError | Image missing or ECR permission issue | Verify image tag and Task Execution Role |
| Task stopped immediately | Application crashed | Check CloudWatch logs |
| Target unhealthy | Incorrect port or health check path | Verify container port and ALB configuration |
| AccessDeniedException | Missing IAM permissions | Update IAM role policies |

## 15.7 Conclusion

You now have a production-style ECS deployment using Fargate, ECR, and an Application Load Balancer.

---

# 16. Best Practices

- Use Fargate for serverless workloads.
- Store secrets in AWS Secrets Manager.
- Use Task Roles instead of embedding AWS credentials.
- Enable ECR image scanning.
- Configure ECR lifecycle policies.
- Use ALB with health checks.
- Keep at least two tasks running in production.
- Use CloudWatch for logs and metrics.
- Use Infrastructure as Code (Terraform/CloudFormation) for repeatable deployments.

---

# 17. Common Interview Questions

1. Why does ECS require a Task Definition?
2. What is the difference between Task Role and Task Execution Role?
3. ECS EC2 vs Fargate—when would you choose each?
4. Why is an ALB commonly used with ECS services?
5. What happens if an ECS task fails?
6. What is the purpose of ECR lifecycle policies?
7. ECS vs EKS—which would you recommend for a startup and why?
8. What are Kubernetes worker nodes?
9. Why are Persistent Volumes needed in Kubernetes?
10. What are the advantages of using EFS with ECS or EKS?

---

# 18. Summary

- Docker packages applications; orchestration platforms manage them at scale.
- ECS is AWS's native container orchestration service, while EKS provides managed Kubernetes.
- Task Definitions describe how containers should run, and Services ensure the desired number of tasks remain healthy.
- ECS supports both EC2 and Fargate launch types, integrating seamlessly with ALB, IAM, Auto Scaling, and ECR.
- Persistent storage is provided through EFS or host volumes in ECS and CSI-backed storage (EBS/EFS) in EKS.
- Choose ECS for simpler AWS-centric deployments and EKS when Kubernetes portability or ecosystem integration is a requirement.

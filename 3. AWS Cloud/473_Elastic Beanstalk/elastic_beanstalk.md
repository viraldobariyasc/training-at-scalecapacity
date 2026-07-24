# 1. Overview & Need

## 1.1 What is AWS Elastic Beanstalk?

AWS Elastic Beanstalk is a Platform as a Service (PaaS) offered by AWS that allows developers to deploy and manage web applications without manually configuring the underlying infrastructure.

Instead of creating EC2 instances, Load Balancers, Auto Scaling Groups, and Security Groups manually, Elastic Beanstalk provisions and manages them automatically.

You only need to upload your application code.

---

## 1.2 Why Use Elastic Beanstalk?

Without Elastic Beanstalk, deploying an application typically involves:

- Launching EC2 instances
- Configuring Security Groups
- Creating Load Balancers
- Configuring Auto Scaling
- Monitoring instance health
- Deploying application updates

Elastic Beanstalk automates all of these tasks.

---

## 1.3 Features

- Easy application deployment
- Automatic provisioning of AWS resources
- Auto Scaling support
- Load Balancer integration
- Health monitoring
- Application version management
- Supports rolling updates

---

## 1.4 Supported Platforms

Elastic Beanstalk supports multiple programming languages and platforms.

Examples:

- Java
- Spring Boot
- Node.js
- Python
- PHP
- .NET
- Go
- Docker
- Ruby

---

## 1.5 Architecture

```
Developer
     │
Upload Application
     │
Elastic Beanstalk
     │
────────────────────────────
│            │            │
EC2      Load Balancer   Auto Scaling
│
Application
```

Developers interact with Beanstalk, while AWS manages the infrastructure.

---

# 2. Deployment Options for Updates

When deploying a new application version, Elastic Beanstalk offers several deployment strategies.

---

## 2.1 All at Once

All instances are updated simultaneously.

```
Before

EC2-1
EC2-2
EC2-3

↓

Deploy

↓

All Updated
```

### Advantages

- Fastest deployment.

### Disadvantages

- Temporary downtime.
- Entire application may become unavailable if deployment fails.

Suitable for:

- Development
- Testing

---

## 2.2 Rolling Deployment

Updates a few instances at a time.

```
Batch 1 Updated

↓

Batch 2 Updated

↓

Batch 3 Updated
```

### Advantages

- Reduced downtime.
- Lower deployment risk.

### Disadvantages

- Deployment takes longer.

---

## 2.3 Rolling with Additional Batch

Elastic Beanstalk launches an extra batch of instances before updating existing ones.

Advantages:

- No reduction in application capacity during deployment.
- Better availability.

Disadvantage:

- Slightly higher temporary cost.

---

## 2.4 Immutable Deployment

A completely new Auto Scaling Group is created with the new application version.

Traffic is switched only after successful deployment.

Advantages:

- Safest deployment strategy.
- Easy rollback.
- Minimal risk.

Disadvantage:

- Highest temporary cost.

---

## 2.5 Blue/Green Deployment

Two identical environments exist.

```
Blue Environment (Current)

Green Environment (New Version)

↓

Swap CNAME

↓

Users access Green
```

Advantages:

- Near-zero downtime.
- Easy rollback.
- Ideal for production.

---

## 2.6 Comparison

| Deployment Type | Downtime | Risk | Cost |
|-----------------|----------|------|------|
| All at Once | High | High | Low |
| Rolling | Low | Medium | Low |
| Rolling with Additional Batch | Very Low | Low | Medium |
| Immutable | Very Low | Very Low | High |
| Blue/Green | Near Zero | Very Low | High |

---

# 3. Beanstalk Components

Elastic Beanstalk creates and manages several AWS resources.

---

## 3.1 Application

Represents your project.

Example:

```
Student Portal
Hotel Booking
Inventory System
```

---

## 3.2 Application Version

Each deployment is stored as an application version.

Example:

```
v1.0

↓

v1.1

↓

v2.0
```

Allows rollback to previous versions.

---

## 3.3 Environment

An environment is where the application runs.

It contains AWS resources such as:

- EC2
- Auto Scaling Group
- Load Balancer
- Security Groups

Each application can have multiple environments.

Example:

```
Development

Testing

Production
```

---

## 3.4 Environment Types

### Single Instance

```
EC2
```

Used for:

- Development
- Testing

---

### Load Balanced Environment

```
ALB
 │
────────────
│          │
EC2      EC2
```

Used for:

- Production
- High Availability

---

# 4. Lifecycle Policies

Lifecycle Policies automatically remove old application versions.

Without lifecycle policies:

```
Version 1
Version 2
Version 3
...
Version 100
```

Old versions consume storage.

Lifecycle Policies can:

- Delete old application versions.
- Delete old source bundles from S3.
- Retain only the latest versions.

Benefits:

- Saves storage.
- Keeps the environment clean.

---

# 5. Beanstalk Extensions

Elastic Beanstalk Extensions are configuration files used to customize the environment.

Extension files are placed inside:

```
.ebextensions/
```

Common use cases:

- Install additional software.
- Configure environment variables.
- Install packages.
- Modify EC2 configuration.
- Execute commands during deployment.

Example structure:

```
Application

├── src
├── pom.xml
└── .ebextensions
      └── config.config
```

---

# 6. Practical

## Objective

Deploy a Spring Boot application using AWS Elastic Beanstalk.

---

## Prerequisites

- AWS Account
- Java application (JAR/WAR)
- IAM permissions
- Elastic Beanstalk service enabled

---

## Steps

### Create an Application

1. Open AWS Console.
2. Navigate to Elastic Beanstalk.
3. Click **Create Application**.
4. Enter the application name.

---

### Create an Environment

1. Choose the platform (Java).
2. Select **Load Balanced** or **Single Instance**.
3. Configure the instance type.
4. Configure the environment.

---

### Deploy the Application

1. Upload the application package.
2. Wait for deployment.
3. Verify environment health.

---

### Update the Application

1. Upload a new application version.
2. Select a deployment strategy.
3. Deploy.
4. Verify the update.

---

## Verification

- Access the application URL.
- Check environment health.
- Verify application logs.
- Confirm the latest version is running.

---

## Expected Outcome

- Successfully deployed an application.
- Updated the application using a deployment strategy.
- Understood Beanstalk components and environment management.

---

# 7. Extra Topics

## 7.1 Supported Platforms

Elastic Beanstalk supports:

- Java
- Node.js
- Python
- PHP
- Go
- Docker
- Ruby
- .NET

---

## 7.2 Environment Types

| Single Instance | Load Balanced |
|-----------------|---------------|
| One EC2 | Multiple EC2 Instances |
| No High Availability | High Availability |
| Lower Cost | Better Reliability |
| Development | Production |

---

## 7.3 Configuration Management

Elastic Beanstalk allows configuration of:

- Environment Variables
- Instance Type
- Security Groups
- Auto Scaling
- Load Balancer
- Health Checks

Most changes can be made without recreating the environment.

---

## 7.4 Elastic Beanstalk vs EC2

| Elastic Beanstalk | EC2 |
|-------------------|-----|
| Platform as a Service (PaaS) | Infrastructure as a Service (IaaS) |
| AWS manages infrastructure | User manages infrastructure |
| Easy deployment | Manual deployment |
| Automatic scaling | Manual configuration |
| Automatic Load Balancer integration | Must be configured manually |

---

# 8. Interview Questions

### Q1. What is AWS Elastic Beanstalk?

Elastic Beanstalk is a Platform as a Service (PaaS) that automates application deployment and infrastructure management.

---

### Q2. Which deployment strategy provides the least risk?

Immutable Deployment and Blue/Green Deployment provide the lowest deployment risk.

---

### Q3. What is the purpose of Lifecycle Policies?

Lifecycle Policies automatically remove old application versions and source bundles to save storage.

---

### Q4. What are Beanstalk Extensions?

Beanstalk Extensions are configuration files stored in the `.ebextensions` directory that customize the deployment environment.

---

### Q5. What is the difference between a Single Instance environment and a Load Balanced environment?

A Single Instance environment uses one EC2 instance and is suitable for development, while a Load Balanced environment uses multiple EC2 instances behind an Application Load Balancer for production workloads.

---

# 9. Summary

- Elastic Beanstalk simplifies application deployment by managing AWS infrastructure automatically.
- It supports multiple deployment strategies, each with different trade-offs for downtime, cost, and risk.
- Applications are organized into Applications, Application Versions, and Environments.
- Lifecycle Policies help manage old application versions.
- Beanstalk Extensions allow environment customization without manually configuring EC2 instances.
- Elastic Beanstalk is ideal for developers who want to focus on application code rather than infrastructure management.
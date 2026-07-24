# 1. EBS Volumes

## 1.1 What is Amazon EBS?

Amazon Elastic Block Store (EBS) is a block storage service that provides persistent storage for Amazon EC2 instances.

Think of an EBS Volume as the **hard disk (SSD/HDD)** of an EC2 instance.

```
EC2 Instance
      │
      │
EBS Volume
```

If the EC2 instance is stopped, the EBS volume and its data remain intact.

---

## 1.2 Features of EBS

- Persistent storage.
- High durability.
- Can be attached and detached from EC2 instances.
- Supports snapshots.
- Supports encryption.
- Can be resized.

---

## 1.3 Characteristics

- Works only with EC2.
- Exists within one Availability Zone.
- Can be backed up using EBS Snapshots.
- Can be attached to one EC2 instance at a time (except Multi-Attach supported volume types).

---

## 1.4 Types of EBS Volumes

| Volume Type | Best For |
|-------------|----------|
| gp3 | General-purpose SSD (recommended) |
| gp2 | Previous generation SSD |
| io1 / io2 | High-performance databases requiring high IOPS |
| st1 | Frequently accessed HDD workloads |
| sc1 | Cold HDD storage |

**Note:** GP3 is generally the recommended choice for most workloads because it offers better performance and pricing than GP2.

---

# 2. EC2 Instance Store

## 2.1 What is Instance Store?

Instance Store is temporary storage physically attached to the host machine where the EC2 instance runs.

Unlike EBS, the data is **ephemeral**, meaning it is lost if the instance is stopped, terminated, or the underlying hardware fails.

```
EC2 Instance
      │
Instance Store
```

---

## 2.2 Characteristics

- Very high performance.
- Low latency.
- Temporary storage.
- No snapshots.
- Cannot be detached.

---

## 2.3 Use Cases

- Cache servers.
- Temporary processing data.
- Scratch space.
- High-speed temporary storage.

Do **not** store important or permanent data on Instance Store.

---

# 3. AMI

## 3.1 What is an AMI?

An Amazon Machine Image (AMI) is a template used to launch EC2 instances.

It contains:

- Operating System.
- Installed software.
- Configuration settings.
- Application code (if customized).

```
AMI

↓

Launch EC2 Instance
```

---

## 3.2 Types of AMIs

### AWS Managed AMIs

Provided and maintained by AWS.

Examples:

- Amazon Linux
- Windows Server

---

### Community AMIs

Created and shared by AWS users.

Always verify the publisher before using them.

---

### Custom AMIs

Created from your own EC2 instances.

Useful for:

- Reusing server configurations.
- Creating identical servers.
- Faster deployments.

---

## 3.3 Why Create a Custom AMI?

Example:

You install:

- Java
- Nginx
- Docker
- Application code

Instead of repeating these steps on every new server, create a Custom AMI and launch identical EC2 instances from it.

---

# 4. EFS

## 4.1 What is Amazon EFS?

Amazon Elastic File System (EFS) is a managed file storage service that can be mounted by multiple EC2 instances simultaneously.

It behaves like a shared network drive.

```
          EFS
        /  |  \
      EC2 EC2 EC2
```

---

## 4.2 Features

- Shared storage.
- Fully managed.
- Automatically scales.
- Multi-AZ availability.
- Supports Linux file systems.
- High durability.

---

## 4.3 Use Cases

- Shared application files.
- Web server content.
- Home directories.
- CMS applications.
- Container workloads (ECS/EKS).

---

## 4.4 Performance Modes

### General Purpose

Suitable for:

- Web applications.
- Content management systems.
- Development environments.

---

### Max I/O

Suitable for:

- Big data.
- Parallel workloads.
- High-throughput applications.

---

# 5. EBS vs EFS

| EBS | EFS |
|-----|-----|
| Block Storage | File Storage |
| Attached to one EC2 (generally) | Shared by multiple EC2 instances |
| Single Availability Zone | Multi-Availability Zone |
| Lower latency | Slightly higher latency |
| Manual resizing | Automatically scales |
| Best for databases and OS disks | Best for shared files |

---

# 6. Practical

## Objective

Understand and work with EBS, Instance Store, AMIs, and EFS.

---

## Prerequisites

- AWS Account.
- EC2 permissions.
- Existing VPC.

---

## Part A – Create an EBS Volume

1. Open the EC2 Console.
2. Navigate to **Volumes**.
3. Click **Create Volume**.
4. Select:
   - Volume Type (gp3)
   - Size
   - Availability Zone
5. Create the volume.
6. Attach it to an EC2 instance.

---

## Part B – Create an EBS Snapshot

1. Select the EBS Volume.
2. Click **Actions → Create Snapshot**.
3. Wait for the snapshot to complete.

---

## Part C – Create a Custom AMI

1. Select an EC2 instance.
2. Click **Actions → Image and templates → Create Image**.
3. Enter the AMI name.
4. Create the image.
5. Launch a new EC2 instance using the custom AMI.

---

## Part D – Create an EFS File System

1. Open the Amazon EFS Console.
2. Click **Create File System**.
3. Select the VPC.
4. Configure Mount Targets.
5. Attach the EFS to a Linux EC2 instance.
6. Mount the file system and create a test file.

---

## Verification

- Confirm the EBS volume is attached and accessible.
- Verify the snapshot status is **Completed**.
- Launch an EC2 instance from the custom AMI and check that the pre-installed software is present.
- Access the same EFS file from multiple EC2 instances (if available).

---

## Expected Outcome

- Successfully created and attached an EBS volume.
- Created an EBS snapshot.
- Created a custom AMI.
- Mounted and used an EFS file system.

---

# 7. Extra Topics

## 7.1 EBS Volume Types

| Volume Type | Workload |
|-------------|----------|
| gp3 | General-purpose SSD |
| io2 | Mission-critical databases |
| st1 | Throughput-intensive HDD |
| sc1 | Low-cost archival HDD |

Choose the volume type based on performance and cost requirements.

---

## 7.2 EBS Snapshots

Snapshots are incremental backups of EBS volumes.

Benefits:

- Disaster recovery.
- Data migration.
- Volume restoration.

Snapshots are stored by AWS and can be used to create new EBS volumes.

---

## 7.3 EFS Performance Modes

| General Purpose | Max I/O |
|-----------------|---------|
| Lower latency | Higher throughput |
| Small to medium workloads | Large-scale parallel workloads |

---

## 7.4 Storage Selection Guide

| Service | Best For |
|----------|----------|
| EBS | EC2 operating system disks and databases |
| EFS | Shared file storage across multiple EC2 instances |
| Instance Store | Temporary high-speed storage |
| S3 | Object storage for files, backups, logs, and media |

---

## 7.5 Encryption for EBS & EFS

### EBS Encryption

- Uses AWS KMS.
- Encrypts data at rest.
- Encrypts snapshots automatically when enabled.

### EFS Encryption

Supports:

- Encryption at Rest.
- Encryption in Transit (TLS).

Both improve data security and help meet compliance requirements.

---

# 8. Interview Questions

### Q1. What is Amazon EBS?

Amazon EBS is a persistent block storage service designed for use with EC2 instances.

---

### Q2. What happens to Instance Store data when an EC2 instance stops?

All data stored in the Instance Store is lost because it is temporary storage.

---

### Q3. What is an AMI?

An AMI is a template containing an operating system and software configuration used to launch EC2 instances.

---

### Q4. Can multiple EC2 instances share the same EBS volume?

Generally, no. An EBS volume is attached to a single EC2 instance at a time (except supported Multi-Attach scenarios).

---

### Q5. Why is EFS preferred for shared storage?

EFS can be mounted by multiple EC2 instances simultaneously and automatically scales as storage needs grow.

---

### Q6. What is the difference between EBS and EFS?

EBS is block storage designed for a single EC2 instance, while EFS is a shared file storage service that supports multiple EC2 instances across multiple Availability Zones.

---

# 9. Summary

- Amazon EBS provides persistent block storage for EC2 instances.
- Instance Store offers high-performance temporary storage that is lost when the instance stops or terminates.
- AMIs are reusable templates for launching EC2 instances.
- Amazon EFS provides scalable shared file storage for multiple Linux EC2 instances.
- Choosing the right storage service depends on workload requirements, performance, availability, and sharing needs.
# 1. EC2 Fundamentals

## 1.1 What is EC2?

Amazon EC2 (Elastic Compute Cloud) is a service that provides virtual servers in the cloud. It allows users to launch, manage, and terminate servers on demand without purchasing physical hardware.

An EC2 instance behaves like a normal computer where you can install applications, databases, web servers, and host websites.

---

## 1.2 Why EC2?

Before cloud computing, organizations had to buy physical servers, maintain hardware, and estimate future capacity.

EC2 solves these problems by providing virtual machines that can be created or removed within minutes.

### Advantages

- Launch servers within minutes.
- Pay only for what you use.
- Easily increase or decrease resources.
- Supports Linux and Windows.
- Integrates with almost every AWS service.

---

## 1.3 EC2 Architecture

```
User
   │
AWS Console / CLI
   │
Launch EC2 Instance
   │
AMI + Instance Type + Storage + Network + Security Group
   │
Running Virtual Machine
```

---

# 2. EC2 Sizing & Configuration Options

When launching an EC2 instance, several configurations must be selected.

---

## 2.1 Amazon Machine Image (AMI)

An AMI is a template used to launch an EC2 instance.

It contains:

- Operating System
- Pre-installed software
- Configuration settings

Examples:

- Amazon Linux
- Ubuntu
- Windows Server
- Red Hat Enterprise Linux

---

## 2.2 Instance Type

Instance type defines:

- CPU
- Memory (RAM)
- Network Performance
- Storage Performance

Example:

| Instance Type | Purpose |
|--------------|---------|
| t2.micro | Free Tier, testing |
| t3.medium | Small applications |
| m5.large | General purpose |
| c5.large | Compute-intensive workloads |
| r5.large | Memory-intensive applications |

---

## 2.3 Storage

EC2 supports multiple storage options.

Most commonly:

- EBS (Elastic Block Store)
- Instance Store

---

## 2.4 Network Configuration

While launching an instance, select:

- VPC
- Subnet
- Public IP option
- Security Group

---

## 2.5 Key Pair

A Key Pair is used to securely connect to Linux EC2 instances.

It consists of:

- Public Key (stored by AWS)
- Private Key (.pem file stored by user)

---

# 3. EC2 Purchasing Options

AWS offers different purchasing models.

---

## 3.1 On-Demand

- Pay per hour or second.
- No long-term commitment.
- Best for development and testing.

---

## 3.2 Reserved Instances

- Reserve capacity for 1 or 3 years.
- Lower cost compared to On-Demand.
- Suitable for predictable workloads.

---

## 3.3 Spot Instances

Unused AWS capacity offered at a significant discount.

Advantages:

- Very low cost.

Disadvantages:

- AWS can terminate the instance at any time.

Best for:

- Batch jobs
- Testing
- Big data processing

---

## 3.4 Dedicated Hosts / Dedicated Instances

Physical servers dedicated to a single customer.

Used when licensing or compliance requires dedicated hardware.

---

# 4. Ways to Connect to an Instance

## 4.1 SSH

Used to connect to Linux instances.

Example:

```bash
ssh -i key.pem ubuntu@<Public-IP>
```

---

## 4.2 EC2 Instance Connect

Browser-based SSH connection provided by AWS.

No local SSH client required.

---

## 4.3 Session Manager

Provided by AWS Systems Manager (SSM).

Advantages:

- No SSH port required.
- No public IP required.
- More secure.

---

## 4.4 RDP

Used to connect to Windows EC2 instances.

---

# 5. Security Groups

A Security Group acts as a virtual firewall for an EC2 instance.

It controls:

- Incoming traffic (Inbound Rules)
- Outgoing traffic (Outbound Rules)

Example:

| Port | Protocol | Purpose |
|------|----------|----------|
| 22 | SSH | Linux Login |
| 80 | HTTP | Website |
| 443 | HTTPS | Secure Website |
| 3306 | MySQL | Database |

### Characteristics

- Stateful
- Allow rules only
- Attached to ENIs (Elastic Network Interfaces)

---

# 6. User Data

User Data is a script that runs automatically during the first boot of an EC2 instance.

Common uses:

- Install packages
- Update OS
- Configure web server
- Deploy applications

Example:

```bash
#!/bin/bash
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
```

---

# 7. Public IP vs Private IP

## Public IP

- Accessible from the Internet.
- Assigned by AWS.
- Can change when the instance stops and starts.

Example:

```
54.210.15.100
```

---

## Private IP

- Used for communication within the VPC.
- Cannot be accessed directly from the Internet.
- Remains the same throughout the instance's lifetime.

Example:

```
10.0.1.15
```

---

## Difference

| Public IP | Private IP |
|------------|------------|
| Internet accessible | Internal communication |
| Globally unique | Unique within VPC |
| May change | Usually remains constant |

---

# 8. Elastic IPs

An Elastic IP is a static public IPv4 address.

Advantages:

- Permanent public IP.
- Can be moved between instances.

Use Case:

If an EC2 instance fails, the Elastic IP can be associated with another instance without changing the public IP.

---

# 9. ENI (Elastic Network Interface)

An ENI is a virtual network card attached to an EC2 instance.

It contains:

- Private IP
- Public IP (if assigned)
- Elastic IP (optional)
- Security Groups
- MAC Address

One EC2 instance can have multiple ENIs.

---

# 10. Practical

## Objective

Launch an EC2 instance and connect to it.

---

## Prerequisites

- AWS Account
- Key Pair
- Basic knowledge of SSH

---

## Steps

### Launch an EC2 Instance

1. Open AWS Console.
2. Navigate to EC2.
3. Click **Launch Instance**.
4. Enter an instance name.
5. Select an AMI.
6. Choose an instance type.
7. Select or create a Key Pair.
8. Configure Network Settings.
9. Attach a Security Group.
10. Launch the instance.

---

### Connect Using SSH

```bash
chmod 400 mykey.pem

ssh -i mykey.pem ubuntu@<Public-IP>
```

---

### Verify

```bash
hostname

whoami

pwd
```

---

### Stop and Start Instance

1. Select the EC2 instance.
2. Choose **Instance State**.
3. Stop the instance.
4. Start the instance again.

Observe whether the Public IP changes.

---

## Expected Outcome

- Successfully launched an EC2 instance.
- Connected using SSH.
- Understood Security Groups.
- Executed Linux commands.
- Verified User Data execution (if configured).

---

# 11. Extra Topics

## 11.1 EC2 Instance Lifecycle

```
Pending
   │
Running
   │
Stopping
   │
Stopped
   │
Starting
   │
Running
   │
Terminated
```

A terminated instance cannot be restarted.

---

## 11.2 AMI (Amazon Machine Image)

An AMI is a reusable template used to launch EC2 instances.

You can create custom AMIs after configuring an instance.

---

## 11.3 EBS Overview

Elastic Block Store (EBS) provides persistent storage for EC2 instances.

Data remains even after stopping the instance.

---

## 11.4 EC2 Placement Groups

Placement Groups control how EC2 instances are physically placed.

Types:

- Cluster
- Partition
- Spread

Used for performance and fault tolerance.

---

## 11.5 Instance Metadata Service (IMDS)

IMDS provides metadata about the running EC2 instance.

Commonly used to retrieve:

- Instance ID
- Region
- IAM Role Credentials
- Availability Zone

Example:

```bash
curl http://169.254.169.254/latest/meta-data/
```

---

# 12. Interview Questions

### Q1. What is EC2?

EC2 is a service that provides virtual servers in the AWS Cloud.

---

### Q2. What is the difference between Public IP and Elastic IP?

A Public IP is automatically assigned and may change, whereas an Elastic IP is static and remains the same until released.

---

### Q3. Why is a Key Pair required?

To securely authenticate while connecting to a Linux EC2 instance using SSH.

---

### Q4. Why are Security Groups called stateful?

If inbound traffic is allowed, the corresponding outbound response is automatically allowed.

---

### Q5. What is User Data?

User Data is a startup script executed during the first boot of an EC2 instance.

---

### Q6. What is ENI?

An ENI (Elastic Network Interface) is a virtual network interface attached to an EC2 instance.

---

# 13. Summary

- EC2 provides virtual machines in the AWS Cloud.
- AMIs, Instance Types, Storage, Networking, and Security Groups define an EC2 instance.
- Security Groups act as virtual firewalls.
- User Data automates instance configuration.
- Public IP, Private IP, Elastic IP, and ENIs are essential networking concepts.
- Understanding EC2 fundamentals is the foundation for deploying applications on AWS.
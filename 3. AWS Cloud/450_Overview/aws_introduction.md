# 1. About AWS

## 1.1 What is AWS?

Amazon Web Services (AWS) is a cloud computing platform provided by Amazon. It offers more than 200 cloud services such as virtual servers, storage, databases, networking, security, analytics, artificial intelligence, and many more.

Instead of purchasing physical servers and maintaining them, organizations can rent resources from AWS and pay only for what they use.

---

## 1.2 Why AWS?

Before cloud computing, companies had to:

- Purchase physical servers.
- Build data centers.
- Maintain hardware.
- Replace servers after a few years.
- Estimate future capacity.

AWS solves these problems by providing infrastructure on demand.

### Benefits of AWS

- Pay only for what you use.
- Highly scalable.
- High availability.
- Secure infrastructure.
- Global presence.
- Quick deployment.
- Large collection of managed services.

---

## 1.3 Traditional Infrastructure vs AWS

| Traditional Infrastructure | AWS Cloud |
|----------------------------|-----------|
| Buy physical servers | Rent virtual servers |
| High upfront investment | Pay-as-you-go |
| Manual scaling | Automatic scaling |
| Hardware maintenance | Managed by AWS |
| Longer deployment time | Deploy within minutes |

---

# 2. AWS Global Infrastructure

AWS has a global network of infrastructure to provide reliable and low-latency cloud services.

```
AWS Global Infrastructure
│
├── Regions
│      ├── Availability Zones
│      │       └── Data Centers
│
├── Edge Locations
│
└── Local Zones
```

---

## 2.1 Regions

A Region is a physical geographic location where AWS has infrastructure.

Examples:

- Mumbai (ap-south-1)
- Hyderabad (ap-south-2)
- Singapore (ap-southeast-1)
- North Virginia (us-east-1)
- Frankfurt (eu-central-1)

### Why Multiple Regions?

- Lower latency
- Disaster recovery
- Meet legal requirements
- High availability

---

## 2.2 Availability Zones (AZs)

Each Region contains multiple Availability Zones.

An Availability Zone consists of one or more physically separate data centers connected by high-speed networking.

Example:

```
Mumbai Region

├── ap-south-1a
├── ap-south-1b
└── ap-south-1c
```

### Why use multiple AZs?

If one AZ becomes unavailable, resources in another AZ continue serving users.

---

## 2.3 Data Centers

A Data Center is the physical building where AWS keeps:

- Servers
- Storage devices
- Networking equipment
- Cooling systems
- Power backup

Users do not choose individual data centers. AWS automatically places resources inside the selected Availability Zone.

---

## 2.4 Edge Locations

Edge Locations are small AWS sites located close to users.

They are mainly used by:

- Amazon CloudFront
- Route 53
- AWS Shield
- AWS WAF

### Purpose

- Reduce latency
- Cache frequently accessed content
- Improve website performance

Example:

If a website is hosted in Mumbai and a user accesses it from Ahmedabad, cached content may be delivered from a nearby Edge Location instead of the Mumbai Region.

---

## 2.5 Local Zones

Local Zones extend AWS services closer to major cities.

Unlike Edge Locations, Local Zones can run services like EC2 and EBS.

### Use Cases

- Gaming
- Video editing
- Media streaming
- Machine Learning
- Real-time applications

---

## 2.6 Difference Between Global Infrastructure Components

| Component | Purpose |
|-----------|---------|
| Region | Geographic location containing AWS infrastructure |
| Availability Zone | Isolated location inside a Region |
| Data Center | Physical building containing servers |
| Edge Location | Delivers cached content closer to users |
| Local Zone | Extends compute and storage closer to cities |

---

# 3. AWS Cloud Shell

AWS CloudShell is a browser-based Linux terminal available directly from the AWS Management Console.

It comes with:

- AWS CLI
- Bash Shell
- Python
- Git
- Common development tools

No installation or configuration is required.

---

## 3.1 Benefits

- No local setup required.
- AWS CLI is already installed.
- Uses your logged-in AWS credentials.
- Accessible from any browser.

---

## 3.2 Common Commands

Check AWS CLI version:

```bash
aws --version
```

Display current AWS account information:

```bash
aws sts get-caller-identity
```

List S3 buckets:

```bash
aws s3 ls
```

Exit CloudShell:

```bash
exit
```

---

# 4. Practical

## Objective

Understand AWS Global Infrastructure and use AWS CloudShell.

## Steps

1. Login to the AWS Management Console.
2. Observe the selected Region.
3. Change the Region from the top-right corner.
4. Open AWS CloudShell.
5. Verify the AWS CLI installation:

```bash
aws --version
```

6. Display your AWS account details:

```bash
aws sts get-caller-identity
```

7. List all available S3 buckets:

```bash
aws s3 ls
```

8. Exit CloudShell.

```bash
exit
```

---

## Expected Outcome

- Successfully opened AWS CloudShell.
- Executed basic AWS CLI commands.
- Understood the relationship between Regions, Availability Zones, Data Centers, Edge Locations, and Local Zones.

---

# 5. Extra Topics

## 5.1 Benefits of Cloud Computing

- Lower infrastructure cost
- Faster deployment
- Automatic scaling
- Global access
- High availability
- Better security

---

## 5.2 AWS Shared Responsibility Model

AWS is responsible for **Security of the Cloud**, including:

- Physical servers
- Networking
- Data centers
- Hardware

Customers are responsible for **Security in the Cloud**, including:

- IAM Users
- Applications
- Data
- Security Groups
- Operating System updates (EC2)

---

## 5.3 Global Services vs Regional Services

### Global Services

- IAM
- Route 53
- CloudFront

### Regional Services

- EC2
- VPC
- RDS
- EBS
- S3 (buckets are created in a specific Region)

---

## 5.4 Choosing an AWS Region

While selecting a Region, consider:

- Distance from users
- Pricing
- Service availability
- Compliance requirements
- Disaster recovery strategy

---

# 6. Interview Questions

### Q1. What is AWS?

AWS is Amazon's cloud computing platform that provides on-demand cloud services such as compute, storage, networking, databases, and security.

### Q2. What is the difference between a Region and an Availability Zone?

A Region is a geographical location, while an Availability Zone is an isolated location within a Region containing one or more data centers.

### Q3. What are Edge Locations used for?

They are used to cache and deliver content closer to users, reducing latency.

### Q4. What is AWS CloudShell?

AWS CloudShell is a browser-based Linux terminal with AWS CLI pre-installed for managing AWS resources.

---

# 7. Summary

- AWS is the world's leading cloud computing platform.
- AWS Global Infrastructure consists of Regions, Availability Zones, Data Centers, Edge Locations, and Local Zones.
- AWS CloudShell provides a ready-to-use Linux environment with AWS CLI.
- Understanding the AWS Global Infrastructure is essential before learning AWS services such as EC2, S3, VPC, and RDS.
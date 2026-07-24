# 1. Understand RTO & RPO

## 1.1 What is Disaster Recovery (DR)?

Disaster Recovery (DR) is the process of restoring applications, databases, and infrastructure after an unexpected event such as:

- Hardware failure
- Data corruption
- Human error
- Natural disasters
- Power outages
- Cyber attacks

The goal is to minimize downtime and data loss.

---

## 1.2 What is RTO (Recovery Time Objective)?

RTO is the **maximum acceptable time** an application can remain unavailable after a disaster.

It answers the question:

**"How quickly must the application be restored?"**

Example:

An online shopping website has an RTO of **30 minutes**.

If the application goes down at **10:00 AM**, it should be restored before **10:30 AM**.

```
Application Failure
        │
        │ 30 Minutes
        ▼
Application Restored
```

Lower RTO requires better infrastructure and usually increases cost.

---

## 1.3 What is RPO (Recovery Point Objective)?

RPO is the **maximum acceptable amount of data loss**.

It answers the question:

**"How much data can we afford to lose?"**

Example:

If backups are taken every 15 minutes, the maximum possible data loss is 15 minutes.

```
Backup
   │
15 Minutes
   │
Failure
```

RPO = 15 Minutes

Lower RPO requires more frequent replication or backups.

---

## 1.4 Difference Between RTO & RPO

| RTO | RPO |
|-----|-----|
| Measures downtime | Measures data loss |
| Time to recover | Time between last valid data and failure |
| Example: 30 minutes | Example: 15 minutes |

Remember:

- **RTO = Service Recovery**
- **RPO = Data Recovery**

---

# 2. Disaster Recovery Strategies based on Different Requirements

AWS provides multiple Disaster Recovery strategies based on business requirements and budget.

---

## 2.1 Backup & Restore

This is the simplest and least expensive DR strategy.

Process:

1. Take backups regularly.
2. Store them safely (S3, Glacier, Snapshots).
3. Restore resources when needed.

```
Application
      │
Take Backup
      │
S3 / Snapshots
      │
Restore After Failure
```

### Advantages

- Lowest cost.
- Easy to implement.

### Disadvantages

- Highest downtime.
- Slower recovery.

Suitable for:

- Development
- Internal applications
- Non-critical workloads

---

## 2.2 Pilot Light

A minimal version of the production environment is always running.

Only critical services such as the database remain active.

```
Production

EC2 + ALB + Database

↓

Disaster Site

Database Running

↓

Launch Remaining Servers
```

### Advantages

- Faster recovery than Backup & Restore.
- Lower cost than full replication.

### Disadvantages

- Recovery still takes time.

---

## 2.3 Warm Standby

A scaled-down version of the production environment runs continuously.

```
Production

10 EC2

↓

Warm Standby

2 EC2

↓

Scale Up During Disaster
```

### Advantages

- Faster recovery.
- Better availability.

### Disadvantages

- Higher cost than Pilot Light.

---

## 2.4 Multi-Site / Active-Active

Production runs simultaneously in two or more Regions.

Traffic is distributed between environments.

```
Users
   │
Route 53
 │      │
Region A  Region B
```

If one Region fails, users are automatically redirected to the other Region.

### Advantages

- Near-zero downtime.
- Very low data loss.
- Highest availability.

### Disadvantages

- Highest cost.
- More complex architecture.

---

## 2.5 Strategy Comparison

| Strategy | Cost | RTO | RPO |
|----------|------|-----|-----|
| Backup & Restore | Low | High | High |
| Pilot Light | Medium | Medium | Medium |
| Warm Standby | High | Low | Low |
| Multi-Site | Highest | Near Zero | Near Zero |

---

# 3. Creating Snapshots from EC2 & RDS for Backups & Restoring them

## 3.1 EC2 Snapshots (EBS Snapshots)

EC2 instance data stored on EBS volumes can be backed up using **EBS Snapshots**.

Snapshots are incremental.

```
EC2
 │
EBS Volume
 │
Create Snapshot
 │
Amazon S3 (Managed by AWS)
```

### Advantages

- Incremental backups.
- Easy restoration.
- Supports disaster recovery.

---

## 3.2 Creating an EC2 Snapshot

### Steps

1. Open the EC2 Console.
2. Select **Volumes**.
3. Choose the EBS volume.
4. Click **Actions → Create Snapshot**.
5. Enter a description.
6. Create the snapshot.

---

## 3.3 Restoring an EC2 Snapshot

1. Open **Snapshots**.
2. Select the snapshot.
3. Choose **Create Volume**.
4. Attach the new volume to an EC2 instance.

Alternatively, create a new AMI from the snapshot and launch a new instance.

---

## 3.4 RDS Snapshots

RDS supports:

- Automated Backups
- Manual Snapshots

Manual snapshots never expire until deleted.

---

## 3.5 Creating an RDS Snapshot

1. Open the RDS Console.
2. Select the database.
3. Click **Actions → Take Snapshot**.
4. Provide a snapshot name.
5. Create the snapshot.

---

## 3.6 Restoring an RDS Snapshot

1. Open **Snapshots**.
2. Select the snapshot.
3. Click **Restore Snapshot**.
4. Configure database settings.
5. Launch the restored database.

A new RDS instance is created from the snapshot.

---

# 4. Practical

## Objective

Create backups of EC2 and RDS resources and restore them.

---

## Prerequisites

- AWS Account
- EC2 instance with an EBS volume
- RDS database instance

---

## Part A – Create an EC2 Snapshot

1. Navigate to **EC2 → Volumes**.
2. Select the attached EBS volume.
3. Click **Actions → Create Snapshot**.
4. Wait for the snapshot to complete.

### Verification

- Confirm the snapshot status changes to **Completed**.

---

## Part B – Restore the EC2 Snapshot

1. Select the snapshot.
2. Create a new EBS volume.
3. Attach it to an EC2 instance.
4. Verify the data is available.

---

## Part C – Create an RDS Snapshot

1. Navigate to **Amazon RDS**.
2. Select the database instance.
3. Click **Take Snapshot**.
4. Wait for completion.

---

## Part D – Restore the RDS Snapshot

1. Select the snapshot.
2. Click **Restore Snapshot**.
3. Create the restored database.
4. Connect using a database client.

---

## Expected Outcome

- Successfully created an EBS snapshot.
- Restored data using a new EBS volume.
- Created an RDS snapshot.
- Restored a new RDS database instance.

---

# 5. Extra Topics

## 5.1 AWS Backup Service

AWS Backup is a centralized service for managing backups across AWS resources.

Supported services include:

- EC2 (EBS)
- RDS
- EFS
- DynamoDB
- EBS
- FSx

Benefits:

- Centralized backup management.
- Backup scheduling.
- Retention policies.
- Cross-account backup support.

---

## 5.2 AMI vs EBS Snapshot

| AMI | EBS Snapshot |
|-----|--------------|
| Used to launch EC2 instances | Backup of an EBS volume |
| Includes OS configuration | Stores only volume data |
| Used for server cloning | Used for storage recovery |

---

## 5.3 Cross-Region Backup Strategy

To protect against Regional failures:

- Copy EBS snapshots to another Region.
- Copy RDS snapshots to another Region.
- Enable Cross-Region Replication where applicable.

This improves disaster recovery capabilities.

---

## 5.4 Backup Best Practices

- Schedule regular backups.
- Test restoration periodically.
- Enable automatic backups for RDS.
- Use lifecycle policies to manage snapshot retention.
- Store critical backups in another AWS Region.
- Encrypt backups using AWS KMS.

---

# 6. Interview Questions

### Q1. What is RTO?

RTO (Recovery Time Objective) is the maximum acceptable time to restore an application after a disaster.

---

### Q2. What is RPO?

RPO (Recovery Point Objective) is the maximum acceptable amount of data loss measured in time.

---

### Q3. Which Disaster Recovery strategy has the lowest cost?

Backup & Restore.

---

### Q4. Which strategy provides the fastest recovery?

Multi-Site (Active-Active).

---

### Q5. What is an EBS Snapshot?

An EBS Snapshot is an incremental backup of an Amazon EBS volume stored by AWS.

---

### Q6. Can an RDS Snapshot overwrite an existing database?

No. Restoring an RDS snapshot always creates a **new database instance**.

---

# 7. Summary

- Disaster Recovery ensures applications and data can be restored after failures.
- RTO measures acceptable downtime, while RPO measures acceptable data loss.
- AWS offers Backup & Restore, Pilot Light, Warm Standby, and Multi-Site DR strategies.
- EBS Snapshots protect EC2 storage, while RDS Snapshots protect relational databases.
- Regular backups and tested recovery procedures are essential for a reliable disaster recovery plan.
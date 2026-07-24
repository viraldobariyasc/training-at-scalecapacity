# 1. Overview

## 1.1 What is Amazon RDS?

Amazon RDS (Relational Database Service) is a managed database service provided by AWS that makes it easy to create, operate, scale, and maintain relational databases.

Instead of installing and managing a database server yourself, AWS manages most of the administrative tasks.

Supported database engines include:

- MySQL
- PostgreSQL
- MariaDB
- Oracle
- Microsoft SQL Server
- Amazon Aurora

---

## 1.2 Why Use RDS?

Managing a database manually requires:

- Installing the database software
- Applying updates and patches
- Taking backups
- Monitoring performance
- Replacing failed hardware
- Configuring replication

RDS automates most of these tasks.

### Benefits

- Easy deployment
- Automatic backups
- High Availability
- Automatic software patching
- Monitoring with CloudWatch
- Easy scaling
- Secure integration with AWS services

---

## 1.3 RDS Architecture

```
Application
      │
      │
Amazon RDS
      │
Database Engine
      │
Storage
```

AWS manages the operating system, hardware, and database maintenance.

---

# 2. Advantages of using RDS over Deploying a DB on EC2

## 2.1 Database on EC2

If you install MySQL or PostgreSQL on an EC2 instance, you are responsible for:

- Installing the database
- Configuring backups
- Monitoring
- Security updates
- Replication
- Disaster recovery
- High Availability

Everything is managed by you.

---

## 2.2 Database on RDS

AWS automatically manages:

- Database installation
- Automatic backups
- Software updates
- Failover
- Monitoring
- Storage scaling
- High Availability

You mainly focus on your application and data.

---

## 2.3 Comparison

| Database on EC2 | Amazon RDS |
|-----------------|------------|
| Manual installation | Managed by AWS |
| Manual backups | Automatic backups |
| Manual patching | Automatic patching |
| Manual failover | Multi-AZ support |
| Manual monitoring | CloudWatch integration |
| Higher administration | Lower administration |

---

# 3. Storage Auto Scaling

Storage Auto Scaling automatically increases database storage when the allocated storage becomes full.

Example:

Allocated Storage:

```
100 GB
```

As the database grows:

```
100 GB
      ↓
150 GB
      ↓
200 GB
```

Benefits:

- Prevents storage shortages.
- No manual intervention required.
- Improves application availability.

---

# 4. RDS Read Replica

A Read Replica is a read-only copy of an RDS database.

It is used to improve read performance.

```
            Primary Database
                   │
          Replication
                   │
        -------------------
        │                 │
Read Replica 1     Read Replica 2
```

Applications send:

- Write requests → Primary Database
- Read requests → Read Replicas

### Advantages

- Improves read performance.
- Reduces load on the primary database.
- Can be promoted to a standalone database if needed.

### Use Cases

- Reporting
- Analytics
- Read-heavy applications

---

# 5. RDS Multi-AZ

Multi-AZ provides High Availability.

AWS creates a standby database in another Availability Zone.

```
Availability Zone A

Primary Database
       │
Synchronous Replication
       │
Availability Zone B

Standby Database
```

If the primary database fails:

- AWS automatically switches to the standby database.

Users usually do not notice the failover.

### Benefits

- High Availability
- Automatic failover
- Better fault tolerance

---

# 6. RDS Backups

Amazon RDS provides two types of backups.

---

## 6.1 Automated Backups

AWS automatically creates backups based on the backup retention period.

Features:

- Point-in-Time Recovery
- Automatic snapshots
- No manual effort

---

## 6.2 Manual Snapshots

Snapshots are created manually.

Features:

- Never expire until deleted.
- Useful before upgrades or major changes.
- Can be restored later.

---

# 7. Practical

## Objective

Create an Amazon RDS database and connect an application to it.

---

## Prerequisites

- AWS Account
- Existing VPC
- Security Group
- EC2 Instance (optional for testing)

---

## Steps

### Create an RDS Instance

1. Open the AWS Console.
2. Search for **RDS**.
3. Click **Create Database**.
4. Choose **Standard Create**.
5. Select a database engine (e.g., MySQL or PostgreSQL).
6. Select an instance class.
7. Configure username and password.
8. Configure storage.
9. Select the VPC and Security Group.
10. Create the database.

---

### Connect to the Database

Example (MySQL):

```bash
mysql -h <endpoint> -u admin -p
```

Example (PostgreSQL):

```bash
psql -h <endpoint> -U postgres
```

---

### Verification

- Login successfully.
- Create a sample database.
- Create a table.
- Insert sample records.
- Retrieve the records.

---

## Expected Outcome

- Successfully created an RDS instance.
- Connected using a database client.
- Performed basic database operations.

---

# 8. Extra Topics

## 8.1 Supported Database Engines

Amazon RDS supports:

- MySQL
- PostgreSQL
- MariaDB
- Oracle
- Microsoft SQL Server
- Amazon Aurora

---

## 8.2 RDS Instance Classes

Instance classes determine:

- CPU
- RAM
- Network performance

Examples:

- db.t3.micro
- db.t3.small
- db.m5.large
- db.r6g.large

---

## 8.3 Security in RDS

Best Practices:

- Deploy RDS in private subnets.
- Restrict access using Security Groups.
- Enable encryption.
- Use IAM authentication where supported.
- Enable automatic backups.

---

## 8.4 RDS Snapshots

Snapshots are manual backups stored in Amazon S3.

Advantages:

- Long-term backup.
- Database migration.
- Disaster recovery.

---

## 8.5 Read Replica vs Multi-AZ

| Read Replica | Multi-AZ |
|--------------|-----------|
| Improves read performance | Improves High Availability |
| Asynchronous replication | Synchronous replication |
| Multiple replicas supported | One standby database |
| Read-only | Standby (not used for reads) |
| Can be promoted | Automatic failover |

---

# 9. Interview Questions

### Q1. What is Amazon RDS?

Amazon RDS is a managed relational database service that simplifies database administration.

---

### Q2. Why should RDS be preferred over installing a database on EC2?

Because AWS manages backups, patching, monitoring, failover, storage scaling, and maintenance.

---

### Q3. What is the purpose of a Read Replica?

It improves read performance by handling read requests separately from the primary database.

---

### Q4. What is Multi-AZ?

Multi-AZ creates a standby database in another Availability Zone to provide High Availability and automatic failover.

---

### Q5. What is Storage Auto Scaling?

It automatically increases storage capacity when the database approaches its storage limit.

---

### Q6. What is the difference between Automated Backups and Snapshots?

Automated Backups are scheduled and support Point-in-Time Recovery, while Snapshots are manual backups that remain until deleted.

---

# 10. Summary

- Amazon RDS is a managed relational database service.
- It reduces administrative effort by automating maintenance tasks.
- Storage Auto Scaling prevents storage shortages.
- Read Replicas improve read performance.
- Multi-AZ provides High Availability through automatic failover.
- Automated Backups and Snapshots protect against data loss.
- RDS is generally preferred over running databases directly on EC2 for most production workloads.
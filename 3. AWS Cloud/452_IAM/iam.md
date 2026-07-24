# 1. About IAM

## 1.1 What is IAM?

IAM (Identity and Access Management) is an AWS service used to securely manage access to AWS resources.

It allows you to:
- Create users.
- Organize users into groups.
- Assign permissions.
- Create roles for AWS services.
- Secure AWS accounts using authentication methods.

**IAM is a Global Service**, meaning it is not tied to any specific AWS Region.

---

## 1.2 Why Do We Need IAM?

Imagine a company with multiple employees:

- Developers
- Testers
- DevOps Engineers
- Database Administrators
- Managers

Not everyone should have full access to AWS resources.

For example:

- Developers should manage EC2 instances.
- Database Administrators should access RDS.
- Finance team should only view billing.
- Security team should manage IAM.

IAM helps control who can access what.

---

## 1.3 Features of IAM

- Secure access management.
- Fine-grained permissions.
- Multi-Factor Authentication (MFA).
- Temporary credentials.
- Integration with almost every AWS service.
- Free AWS service.

---

# 2. IAM Users & Groups

## 2.1 IAM Users

An IAM User represents a single person or application that needs access to AWS.

Each IAM User has:

- Username
- Password (Console Access)
- Access Keys (CLI/SDK Access)
- Permissions

Example:

```
Developer

Username: viral
```

---

## 2.2 IAM Groups

A Group is a collection of IAM Users.

Instead of assigning permissions to every user individually, permissions are assigned to the group.

Example:

```
Developers Group

├── Viral
├── Rahul
└── Priya
```

The Developers group may have permission to manage EC2 but not delete IAM Users.

### Benefits

- Easier permission management.
- Reduces duplication.
- Simplifies administration.

---

# 3. IAM Permissions & Types of Policies

## 3.1 What are Permissions?

Permissions define what actions a user, group, or role can perform on AWS resources.

Example:

- Launch EC2
- Delete S3 Bucket
- Read DynamoDB Table

---

## 3.2 Types of IAM Policies

### AWS Managed Policies

Created and managed by AWS.

Examples:

- AmazonS3ReadOnlyAccess
- AmazonEC2FullAccess

Best for common use cases.

---

### Customer Managed Policies

Created and managed by your AWS account.

Useful when AWS managed policies do not meet your requirements.

---

### Inline Policies

Policies directly attached to a single User, Group, or Role.

Not reusable.

Used for specific permissions.

---

# 4. IAM Policy Structure

IAM policies are written in JSON format.

Example:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "*"
        }
    ]
}
```

---

## 4.1 Important Policy Elements

### Version

Policy language version.

Example:

```
"Version": "2012-10-17"
```

---

### Statement

Contains one or more permission rules.

---

### Effect

Determines whether permission is granted or denied.

Possible values:

- Allow
- Deny

---

### Action

Specifies what operation is allowed.

Examples:

```
ec2:StartInstances
s3:GetObject
lambda:InvokeFunction
```

---

### Resource

Specifies which AWS resource the policy applies to.

Example:

```
arn:aws:s3:::my-bucket/*
```

---

# 5. IAM Roles

## 5.1 What is an IAM Role?

An IAM Role is an AWS identity that has permissions but is **not permanently associated with a single user**.

Roles provide temporary credentials.

---

## 5.2 Why Use IAM Roles?

Instead of storing Access Keys inside applications, AWS services can assume a role.

Example:

```
EC2 Instance
      │
Assumes IAM Role
      │
Access S3 Bucket
```

No Access Keys are stored on the EC2 instance.

---

## 5.3 Common Uses

- EC2 accessing S3.
- Lambda accessing DynamoDB.
- Cross-account access.
- ECS/EKS applications.
- Temporary access for users.

---

# 6. IAM Authentication Types

AWS supports multiple authentication methods.

## 6.1 Username & Password

Used for AWS Management Console login.

---

## 6.2 Access Key ID & Secret Access Key

Used with:

- AWS CLI
- SDKs
- APIs

Example:

```bash
aws configure
```

---

## 6.3 Multi-Factor Authentication (MFA)

Requires:

- Password
- OTP from Authenticator App or Hardware Device

Provides additional security.

---

## 6.4 Temporary Credentials

Generated using AWS STS (Security Token Service).

Used by IAM Roles.

---

# 7. IAM Best Practices

- Never use the Root User for daily tasks.
- Enable MFA for the Root User.
- Create IAM Users for individuals.
- Assign permissions using Groups.
- Follow the Principle of Least Privilege.
- Rotate Access Keys regularly.
- Use IAM Roles instead of hardcoding Access Keys.
- Remove unused users and credentials.
- Review permissions regularly.

---

# 8. Practical

## Objective

Create IAM Users, Groups, and Roles, and assign permissions.

---

## Prerequisites

- AWS Account
- IAM access with administrative privileges

---

## Steps

### Create an IAM User

1. Open AWS Console.
2. Search for **IAM**.
3. Select **Users**.
4. Click **Create User**.
5. Enter a username.
6. Enable console access if required.
7. Assign permissions.
8. Create the user.

---

### Create an IAM Group

1. Open **Groups**.
2. Click **Create Group**.
3. Enter the group name.
4. Attach a policy.
5. Add users.

---

### Create an IAM Role

1. Open **Roles**.
2. Click **Create Role**.
3. Choose the trusted entity (e.g., AWS Service).
4. Select the service (e.g., EC2).
5. Attach required policies.
6. Create the role.

---

## Verification

- Login using the IAM User.
- Verify permissions.
- Attach the IAM Role to an EC2 instance and test access to another AWS service.

---

# 9. Extra Topics

## 9.1 Principle of Least Privilege

Grant only the permissions required to perform a task—nothing more.

Example:

If a user only needs to read S3 objects, provide `AmazonS3ReadOnlyAccess` instead of full S3 access.

---

## 9.2 Root User vs IAM User

| Root User | IAM User |
|------------|----------|
| Full access to all AWS services | Limited permissions based on policies |
| One per AWS account | Multiple users can be created |
| Cannot have permissions restricted | Permissions are configurable |
| Used only for account setup and billing | Used for daily administrative and operational tasks |

---

## 9.3 IAM Policy Evaluation Logic

When AWS evaluates permissions:

1. By default, all requests are denied.
2. An explicit **Allow** grants access.
3. An explicit **Deny** always overrides any Allow.

---

## 9.4 Temporary Credentials (AWS STS)

AWS Security Token Service (STS) issues temporary credentials.

Advantages:

- No long-term access keys.
- More secure.
- Automatically expire after a specified duration.

---

# 10. Interview Questions

### Q1. Is IAM a Global or Regional Service?

IAM is a **Global Service**.

---

### Q2. What is the difference between an IAM User and an IAM Role?

An IAM User is a permanent identity for a person or application, while an IAM Role provides temporary credentials that can be assumed by users or AWS services.

---

### Q3. Why should IAM Roles be preferred over Access Keys?

IAM Roles provide temporary credentials, eliminating the need to store long-term access keys in applications.

---

### Q4. What is the Principle of Least Privilege?

Grant users only the minimum permissions required to perform their tasks.

---

### Q5. What happens if both Allow and Deny are present?

An explicit **Deny** always overrides an **Allow**.

---

# 11. Summary

- IAM manages authentication and authorization in AWS.
- Users represent individuals, while Groups simplify permission management.
- Policies define permissions using JSON.
- Roles provide temporary credentials for users and AWS services.
- Use MFA, least privilege, and IAM Roles to improve security.
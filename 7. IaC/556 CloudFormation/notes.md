# 1. CloudFormation Overview

## 1.1 What is AWS CloudFormation?

AWS CloudFormation is AWS's native **Infrastructure as Code (IaC)** service.

It allows you to define AWS infrastructure in a template file, usually YAML or JSON, and CloudFormation creates and manages those resources for you.

For example, instead of manually doing:

```text
AWS Console
    |
    +--> Create VPC
    |
    +--> Create Subnet
    |
    +--> Create Security Group
    |
    +--> Create EC2
```

you describe the infrastructure in a template:

```text
CloudFormation Template
        |
        v
CloudFormation Stack
        |
        v
AWS Resources
```

Example:

```yaml
Resources:
  MyBucket:
    Type: AWS::S3::Bucket
```

CloudFormation reads this template and creates the S3 bucket.

---

# 2. Why CloudFormation?

Suppose your application requires:

- VPC
- Subnets
- Internet Gateway
- Route Tables
- Security Groups
- EC2
- RDS

Creating everything manually is:

- Slow
- Error-prone
- Difficult to reproduce
- Difficult to maintain

With CloudFormation:

```text
Template
   |
   v
CloudFormation
   |
   +---- VPC
   +---- Subnets
   +---- Security Groups
   +---- EC2
   +---- RDS
```

The infrastructure becomes code.

This means it can be:

- Stored in Git
- Reviewed
- Version controlled
- Reused
- Automated through CI/CD

---

# 3. CloudFormation Use Cases

CloudFormation is commonly used for:

- Creating AWS infrastructure
- Creating complete application environments
- Standardizing infrastructure
- Automating deployments
- Creating development/staging/production environments
- Multi-account infrastructure deployment
- Multi-region deployments
- Infrastructure provisioning through CI/CD

Example:

```text
Git Repository
      |
      v
CloudFormation Template
      |
      v
CI/CD Pipeline
      |
      v
CloudFormation
      |
      v
AWS Infrastructure
```

---

# 4. Important CloudFormation Terminology

Before working practically, understand these terms.

| Term | Meaning |
|---|---|
| Template | YAML/JSON file describing infrastructure |
| Stack | Running instance of a CloudFormation template |
| Resource | AWS resource created/managed by the stack |
| Parameter | Input provided to a template |
| Mapping | Static key-value lookup table |
| Output | Information exposed by a stack |
| Change Set | Preview of changes before applying them |
| Stack Set | Deploys a template across multiple accounts/regions |

---

# 5. Template vs Stack

This is one of the most important concepts.

## Template

A template is the **blueprint**.

Example:

```yaml
Resources:
  MyBucket:
    Type: AWS::S3::Bucket
```

## Stack

A stack is the **actual deployment created from the template**.

Think of:

```text
Template = Blueprint

Stack = Actual Building
```

You can use the same template to create multiple stacks.

```text
                  Template
                     |
          +----------+----------+
          |          |          |
          v          v          v
        Dev        Test       Prod
       Stack       Stack      Stack
```

---

# 6. CloudFormation Workflow

The basic process is:

```text
Write Template
      |
      v
Upload/Commit Template
      |
      v
Create CloudFormation Stack
      |
      v
CloudFormation Reads Template
      |
      v
Create/Update Resources
      |
      v
Stack Status
```

For updates:

```text
Modify Template
      |
      v
Update Stack
      |
      v
CloudFormation Determines Changes
      |
      v
Update Resources
```

---

# 7. Template Structure

A CloudFormation template can contain several sections.

A simplified template:

```yaml
AWSTemplateFormatVersion: '2010-09-09'

Description: Example CloudFormation template

Parameters:
  EnvironmentName:
    Type: String

Resources:
  MyBucket:
    Type: AWS::S3::Bucket

Outputs:
  BucketName:
    Value: !Ref MyBucket
```

Important sections:

```text
AWSTemplateFormatVersion
Description
Parameters
Mappings
Conditions
Resources
Outputs
Metadata
```

Not every template needs every section.

---

# 8. Resources

## 8.1 What is a Resource?

`Resources` is the most important section.

It defines the AWS resources CloudFormation should create or manage.

Example:

```yaml
Resources:

  MyBucket:
    Type: AWS::S3::Bucket
```

Here:

```text
MyBucket
    |
    +--> Logical ID

AWS::S3::Bucket
    |
    +--> Resource Type
```

---

# 9. Resource Logical ID

The name:

```yaml
MyBucket:
```

is the **Logical ID**.

It is used to reference the resource inside the template.

Example:

```yaml
Resources:

  MyBucket:
    Type: AWS::S3::Bucket

Outputs:

  Bucket:
    Value: !Ref MyBucket
```

`MyBucket` does not necessarily become the physical AWS resource name.

CloudFormation creates a physical resource based on AWS's naming behavior unless you explicitly provide a name.

---

# 10. Practical: First CloudFormation Template

## Objective

Create an S3 bucket using CloudFormation.

Create:

```text
s3-bucket.yaml
```

Add:

```yaml
AWSTemplateFormatVersion: '2010-09-09'

Description: Simple S3 bucket example

Resources:

  MyBucket:
    Type: AWS::S3::Bucket
```

Create the stack using AWS CLI:

```bash
aws cloudformation create-stack \
  --stack-name my-first-stack \
  --template-body file://s3-bucket.yaml
```

Check the stack:

```bash
aws cloudformation describe-stacks \
  --stack-name my-first-stack
```

List stacks:

```bash
aws cloudformation list-stacks
```

---

# 11. Stack Lifecycle

A stack can have different statuses.

Common statuses include:

```text
CREATE_IN_PROGRESS
CREATE_COMPLETE
CREATE_FAILED

UPDATE_IN_PROGRESS
UPDATE_COMPLETE
UPDATE_FAILED

DELETE_IN_PROGRESS
DELETE_COMPLETE

ROLLBACK_IN_PROGRESS
ROLLBACK_COMPLETE
```

The exact status depends on what operation CloudFormation is performing.

---

# 12. Parameters

## 12.1 What are Parameters?

Parameters allow users to provide values when creating or updating a stack.

Without parameters:

```yaml
Resources:

  MyBucket:
    Type: AWS::S3::Bucket
```

The template has fixed behavior.

With parameters:

```yaml
Parameters:

  Environment:
    Type: String
    Default: dev
```

Now the user can provide:

```text
dev
staging
prod
```

---

# 13. Parameter Example

```yaml
Parameters:

  Environment:
    Type: String
    Default: dev

    AllowedValues:
      - dev
      - staging
      - prod
```

Use the parameter:

```yaml
Resources:

  MyBucket:
    Type: AWS::S3::Bucket

    Tags:
      - Key: Environment
        Value: !Ref Environment
```

---

# 14. Creating Stack with Parameters

Using CLI:

```bash
aws cloudformation create-stack \
  --stack-name my-app \
  --template-body file://template.yaml \
  --parameters ParameterKey=Environment,ParameterValue=dev
```

CloudFormation passes:

```text
Environment = dev
```

to the template.

---

# 15. Parameter Types

Common types:

| Type | Example |
|---|---|
| String | `dev` |
| Number | `3` |
| List<AWS::EC2::AvailabilityZone::Name> | Multiple AZs |
| AWS::EC2::VPC::Id | Existing VPC |
| AWS::EC2::Subnet::Id | Existing subnet |
| AWS::EC2::KeyPair::KeyName | EC2 key pair |

AWS-specific parameter types help validate inputs.

---

# 16. Mappings

## 16.1 What is a Mapping?

A Mapping is a static lookup table.

It is useful when you need to map one value to another.

Example:

```yaml
Mappings:

  RegionMap:

    ap-south-1:
      AMI: ami-example-123

    us-east-1:
      AMI: ami-example-456
```

Conceptually:

```text
Region
  |
  +--> ap-south-1 --> AMI A
  |
  +--> us-east-1  --> AMI B
```

---

# 17. Using Mappings

CloudFormation provides:

```text
Fn::FindInMap
```

Short form:

```yaml
!FindInMap
```

Example:

```yaml
ImageId: !FindInMap
  - RegionMap
  - !Ref AWS::Region
  - AMI
```

Meaning:

```text
Current Region
      |
      v
RegionMap
      |
      v
Find AMI
```

Mappings are useful when values are known ahead of time.

---

# 18. Outputs

## 18.1 What are Outputs?

Outputs expose useful information after stack creation.

Example:

```yaml
Outputs:

  BucketName:
    Description: Name of created bucket
    Value: !Ref MyBucket
```

After deployment, CloudFormation shows:

```text
BucketName = <bucket-name>
```

---

# 19. Why Outputs Matter

Outputs are useful for:

- Resource IDs
- Resource names
- URLs
- IP addresses
- Values consumed by other stacks

Example:

```yaml
Outputs:

  VPCId:
    Value: !Ref MyVPC

  PublicSubnetId:
    Value: !Ref PublicSubnet
```

---

# 20. Conditions

Conditions allow CloudFormation to create or configure resources based on a condition.

Example:

```yaml
Conditions:

  IsProduction: !Equals
    - !Ref Environment
    - prod
```

Then:

```yaml
Resources:

  ProductionBucket:
    Type: AWS::S3::Bucket
    Condition: IsProduction
```

The bucket is created only when:

```text
Environment = prod
```

---

# 21. Why Conditions Are Useful

Conditions are useful for:

- Production-only resources
- Optional infrastructure
- Different environments
- Conditional configuration

Example:

```text
Environment
    |
    +---- dev
    |      |
    |      +--> No production database
    |
    +---- prod
           |
           +--> Create production database
```

---

# 22. Metadata

`Metadata` provides additional information about the template or resources.

It does not normally define the infrastructure itself.

Example:

```yaml
Metadata:

  Project:
    Name: MyApplication
```

Metadata can also be used by AWS tooling such as CloudFormation-specific interfaces.

For a beginner, remember:

```text
Resources = infrastructure

Metadata = additional information
```

---

# 23. Template Helpers / Intrinsic Functions

CloudFormation provides **intrinsic functions** to dynamically work with values.

Examples:

```text
Ref
Fn::GetAtt
Fn::Join
Fn::Sub
Fn::FindInMap
Fn::If
Fn::Select
Fn::Split
```

These functions are used inside templates.

---

# 24. `Ref`

`Ref` retrieves the value of a parameter or resource.

Example with parameter:

```yaml
Parameters:

  Environment:
    Type: String
```

Use:

```yaml
Value: !Ref Environment
```

If:

```text
Environment = prod
```

then:

```text
!Ref Environment
```

returns:

```text
prod
```

---

# 25. `Ref` with Resources

Example:

```yaml
Resources:

  MyBucket:
    Type: AWS::S3::Bucket

Outputs:

  Bucket:
    Value: !Ref MyBucket
```

For many resources, `Ref` returns the resource's identifier.

The exact value returned depends on the resource type.

This is important: **`Ref` does not always mean "resource name."**

---

# 26. `Fn::GetAtt`

`Fn::GetAtt` retrieves an attribute from a resource.

Example:

```yaml
Outputs:

  BucketArn:
    Value: !GetAtt MyBucket.Arn
```

Here:

```text
MyBucket
    |
    +--> Arn
```

returns the bucket ARN.

---

# 27. `Ref` vs `GetAtt`

| Function | Purpose |
|---|---|
| `Ref` | Gets the primary/reference value |
| `GetAtt` | Gets a specific resource attribute |

Example:

```yaml
!Ref MyBucket
```

versus:

```yaml
!GetAtt MyBucket.Arn
```

Think:

```text
Ref
 ↓
"Identify this resource"

GetAtt
 ↓
"Give me this specific property"
```

---

# 28. `Fn::Sub`

`Fn::Sub` substitutes variables inside a string.

Example:

```yaml
BucketName:
  Value: !Sub "${AWS::StackName}-bucket"
```

If stack name is:

```text
my-app
```

result:

```text
my-app-bucket
```

It is useful for dynamically constructing:

- ARNs
- Names
- URLs
- Resource identifiers

---

# 29. `Fn::Join`

Joins multiple strings.

Example:

```yaml
Value: !Join
  - "-"
  - - my
    - application
    - prod
```

Result:

```text
my-application-prod
```

---

# 30. Pseudo Parameters

CloudFormation provides built-in values called **pseudo parameters**.

Examples:

```text
AWS::Region
AWS::AccountId
AWS::StackName
AWS::Partition
```

Example:

```yaml
Value: !Ref AWS::Region
```

If deployed in Mumbai:

```text
ap-south-1
```

This allows templates to adapt to the deployment environment.

---

# 31. Practical: Parameters + Outputs + Ref

Create:

```text
template.yaml
```

```yaml
AWSTemplateFormatVersion: '2010-09-09'

Description: CloudFormation beginner example

Parameters:

  Environment:
    Type: String
    Default: dev

    AllowedValues:
      - dev
      - prod

Resources:

  MyBucket:
    Type: AWS::S3::Bucket

    Tags:
      - Key: Environment
        Value: !Ref Environment

Outputs:

  BucketName:
    Description: Created S3 bucket
    Value: !Ref MyBucket

  Environment:
    Description: Selected environment
    Value: !Ref Environment
```

Create:

```bash
aws cloudformation create-stack \
  --stack-name beginner-stack \
  --template-body file://template.yaml \
  --parameters ParameterKey=Environment,ParameterValue=dev
```

Check:

```bash
aws cloudformation describe-stacks \
  --stack-name beginner-stack
```

You should see the outputs.

---

# 32. Rollbacks

One of CloudFormation's important features is **automatic rollback**.

Suppose a stack contains:

```text
VPC
 |
 +--> Subnet
 |
 +--> Security Group
 |
 +--> EC2
```

If EC2 creation fails:

```text
VPC        ✓
Subnet     ✓
SG         ✓
EC2        ✗
```

CloudFormation can roll back the stack.

Conceptually:

```text
Create Resources
       |
       v
Something Fails
       |
       v
Rollback
       |
       v
Return to Previous State
```

---

# 33. Why Rollbacks Matter

Without rollback:

```text
Failure
  |
  +--> Some resources created
  +--> Some resources failed
  +--> Partial infrastructure remains
```

Rollback helps avoid leaving partially created infrastructure.

---

# 34. Rollback Statuses

You may see:

```text
CREATE_IN_PROGRESS
       ↓
CREATE_FAILED
       ↓
ROLLBACK_IN_PROGRESS
       ↓
ROLLBACK_COMPLETE
```

For an update:

```text
UPDATE_IN_PROGRESS
       ↓
UPDATE_FAILED
       ↓
UPDATE_ROLLBACK_IN_PROGRESS
       ↓
UPDATE_ROLLBACK_COMPLETE
```

---

# 35. Debugging Rollbacks

When a stack fails, do not immediately guess the problem.

Check stack events:

```bash
aws cloudformation describe-stack-events \
  --stack-name beginner-stack
```

The events usually reveal:

- Which resource failed
- Why it failed
- Error message
- Which operation was running

The CloudFormation **Events** tab in the AWS Console is also extremely useful.

### Screenshot to add

> Add screenshot of CloudFormation Console → Stack → Events showing a failed resource.

---

# 36. Change Sets

## 36.1 What is a Change Set?

A Change Set allows you to **preview changes to an existing stack before actually applying them**.

Example:

Current:

```text
EC2
1 instance
```

You modify template:

```text
EC2
2 instances
```

Instead of immediately updating the stack:

```text
Template
   ↓
Change Set
   ↓
Review
   ↓
Execute
```

---

# 37. Why Change Sets Are Useful

They help answer:

> "What exactly will CloudFormation change?"

before applying the update.

This is especially useful for production.

---

# 38. Change Set Example

Create a change set:

```bash
aws cloudformation create-change-set \
  --stack-name my-stack \
  --change-set-name my-update \
  --template-body file://updated-template.yaml
```

View it:

```bash
aws cloudformation describe-change-set \
  --stack-name my-stack \
  --change-set-name my-update
```

Execute it:

```bash
aws cloudformation execute-change-set \
  --stack-name my-stack \
  --change-set-name my-update
```

---

# 39. Nested Stacks

A large CloudFormation template can become difficult to manage.

Instead, divide infrastructure into smaller templates.

Example:

```text
Root Stack
    |
    +---- VPC Stack
    |
    +---- Database Stack
    |
    +---- Application Stack
```

These are called **Nested Stacks** when child stacks are managed from a parent stack.

---

# 40. Why Nested Stacks?

Advantages:

- Smaller templates
- Reusable components
- Easier maintenance
- Logical separation

Example:

```text
root.yaml
 |
 +--> network.yaml
 |
 +--> database.yaml
 |
 +--> application.yaml
```

---

# 41. Cross-Stack References

Cross-stack references allow one stack to use outputs from another stack.

Example:

```text
Network Stack
     |
     | exports VPC ID
     v
Application Stack
     |
     | imports VPC ID
     v
EC2
```

Network stack:

```yaml
Outputs:

  VPCId:
    Value: !Ref MyVPC

    Export:
      Name: MyVPCId
```

Another stack can import it:

```yaml
VpcId:
  Fn::ImportValue: MyVPCId
```

Short form:

```yaml
VpcId: !ImportValue MyVPCId
```

---

# 42. Nested vs Cross-Stack

| Feature | Nested Stack | Cross-Stack |
|---|---|---|
| Relationship | Parent-child | Independent stacks |
| Managed by | Parent stack | Separate stacks |
| Communication | Parent passes values | Export/Import |
| Best for | Breaking large templates | Sharing resources |
| Example | App stack contains DB stack | Network stack shared by apps |

---

# 43. Stack Sets

## 43.1 What are Stack Sets?

Stack Sets allow you to deploy the same CloudFormation template across:

- Multiple AWS accounts
- Multiple AWS Regions

Example:

```text
             Stack Set
                 |
       +---------+---------+
       |         |         |
       v         v         v
   Account A  Account B  Account C
       |         |         |
       v         v         v
   Mumbai     Mumbai     Singapore
```

This is useful for organizations managing many AWS accounts.

---

# 44. Stack Set Use Cases

Examples:

- Deploy IAM roles to every account
- Standardize security resources
- Create common networking components
- Deploy organization-wide infrastructure
- Maintain consistent configurations

---

# 45. Stack Policies

A Stack Policy protects important resources during stack updates.

Suppose your production database is critical.

You don't want an accidental CloudFormation update to replace it.

A stack policy can restrict certain update actions.

Conceptually:

```text
CloudFormation Update
       |
       v
Stack Policy
       |
       +---- Allowed
       |
       +---- Denied
```

---

# 46. Why Stack Policies Matter

Without protection:

```text
Developer changes template
       |
       v
CloudFormation Update
       |
       v
Critical Resource Replaced
```

With a stack policy:

```text
Developer changes template
       |
       v
CloudFormation Update
       |
       v
Stack Policy
       |
       X
Critical Resource Protected
```

Stack policies are particularly useful for protecting critical resources such as production databases.

---

# 47. CloudFormation vs Terraform

Both are IaC tools, but they have different strengths.

| Feature | CloudFormation | Terraform |
|---|---|---|
| Provider | AWS-native | Multi-cloud |
| Syntax | YAML / JSON | HCL |
| AWS Integration | Excellent | Excellent |
| State | Managed by CloudFormation | Terraform state |
| Multi-cloud | Limited | Strong |
| AWS-native features | Very strong | Strong |
| Learning | Easier if AWS-focused | Broader ecosystem |
| Modules | CloudFormation modules/nested stacks | Terraform modules |
| Change Preview | Change Sets | `terraform plan` |

---

# 48. When to Prefer CloudFormation

CloudFormation is a strong choice when:

- Organization is heavily AWS-focused.
- You want a native AWS IaC solution.
- You want deep integration with AWS services.
- You need Stack Sets.
- Your organization already standardizes on CloudFormation.

---

# 49. When Terraform Can Be Better

Terraform can be preferable when:

- Managing multiple cloud providers.
- Managing AWS + Azure + GCP together.
- You want Terraform's module ecosystem.
- Your organization already uses Terraform extensively.

In real organizations, the choice often depends on:

- Existing tooling
- Team expertise
- Cloud strategy
- Compliance
- State management requirements
- CI/CD architecture

---

# 50. Practical Learning Project

After understanding the individual concepts, build a small project:

```text
CloudFormation Project
        |
        +---- VPC
        |
        +---- Public Subnet
        |
        +---- Security Group
        |
        +---- EC2
        |
        +---- Outputs
```

Then gradually add:

```text
Parameters
     ↓
Mappings
     ↓
Conditions
     ↓
Outputs
     ↓
Change Set
     ↓
Nested Stack
```

Do not start with a huge production-style template.

Build the concepts one at a time.

---

# 51. Recommended Practical Sequence

For your first CloudFormation hands-on work, follow this order:

```text
1. Create S3 Bucket
        ↓
2. Add Parameters
        ↓
3. Add Outputs
        ↓
4. Use Ref
        ↓
5. Use GetAtt
        ↓
6. Add Conditions
        ↓
7. Use Mappings
        ↓
8. Modify Stack
        ↓
9. Create Change Set
        ↓
10. Understand Rollback
        ↓
11. Nested Stack
        ↓
12. Cross-Stack Reference
        ↓
13. Stack Set
        ↓
14. Stack Policy
```

This order is much easier than trying to learn everything at once.

---

# 52. Common Beginner Mistakes

## 52.1 Confusing Template and Stack

Remember:

```text
Template = Definition

Stack = Deployment
```

---

## 52.2 Confusing Parameter and Output

Parameter:

```text
Input
```

Output:

```text
Result / Information exposed
```

Think:

```text
Parameter
   ↓
Input → CloudFormation → Infrastructure
                              ↓
                           Output
```

---

## 52.3 Thinking `Ref` Always Returns ARN

It does not.

What `Ref` returns depends on the resource type.

If you specifically need an attribute such as ARN, use the appropriate attribute:

```yaml
!GetAtt Resource.Arn
```

---

## 52.4 Ignoring Stack Events

When a stack fails, check:

```text
CloudFormation
    ↓
Stack
    ↓
Events
```

before changing random parts of the template.

---

## 52.5 Starting with Huge Templates

Don't immediately start with:

```text
VPC
+ ALB
+ ASG
+ RDS
+ ECS
+ IAM
+ CloudWatch
+ Route53
```

Start with:

```text
S3
 ↓
Parameters
 ↓
Outputs
 ↓
Functions
```

Then move to larger infrastructure.

---

# 53. Best Practices

- Keep templates readable.
- Use YAML when the team finds it easier to maintain.
- Use parameters for environment-specific values.
- Use outputs for important resource information.
- Use change sets for important production updates.
- Protect critical resources with appropriate policies.
- Separate large infrastructure into logical stacks.
- Use Stack Sets for multi-account/multi-region standardization.
- Store templates in Git.
- Use CI/CD to validate and deploy templates.
- Avoid hardcoding sensitive information.
- Check CloudFormation Events when debugging failures.
- Use drift detection to identify manual changes.

---

# 54. Interview Questions

## Basic

1. What is AWS CloudFormation?
2. What is Infrastructure as Code?
3. What is a CloudFormation template?
4. What is a CloudFormation stack?
5. Difference between a template and a stack.
6. What are CloudFormation resources?

## Template Components

7. What are Parameters?
8. What are Mappings?
9. What are Conditions?
10. What are Outputs?
11. What is Metadata?
12. Which CloudFormation sections are mandatory?

## Intrinsic Functions

13. What is `Ref`?
14. What is `Fn::GetAtt`?
15. Difference between `Ref` and `Fn::GetAtt`.
16. What is `Fn::Sub`?
17. What are pseudo parameters?

## Operations

18. What happens when CloudFormation resource creation fails?
19. What is a rollback?
20. What is a Change Set?
21. Why should Change Sets be used in production?

## Advanced

22. What is a Nested Stack?
23. What is a Cross-Stack Reference?
24. Difference between Nested Stacks and Cross-Stack References.
25. What is a Stack Set?
26. When would you use Stack Sets?
27. What is a Stack Policy?
28. How would you protect a production database from accidental replacement?

## Comparison

29. CloudFormation vs Terraform.
30. Why might an organization choose CloudFormation over Terraform?

---

# 55. Summary

CloudFormation is AWS's native Infrastructure as Code service.

The most important mental model is:

```text
CloudFormation Template
          |
          v
       Stack
          |
          v
   AWS Resources
```

The main template components are:

```text
Parameters  → Inputs
Mappings    → Lookup values
Conditions  → Conditional behavior
Resources   → Infrastructure
Outputs     → Exposed values
Metadata    → Additional information
```

Important helper functions include:

```text
Ref
GetAtt
Sub
Join
FindInMap
If
```

For operations:

```text
Create Stack
     ↓
Update Stack
     ↓
Change Set
     ↓
Review
     ↓
Execute
```

If something goes wrong:

```text
Deployment
    ↓
Failure
    ↓
Rollback
```

For larger environments:

```text
Nested Stacks
     ↓
Break large templates into smaller stacks

Cross-Stack References
     ↓
Share outputs between stacks

Stack Sets
     ↓
Deploy across accounts/regions

Stack Policies
     ↓
Protect important resources
```

For your first hands-on experience, focus heavily on:

**Resources → Parameters → Outputs → `Ref` → `GetAtt` → Conditions → Change Sets → Rollbacks.**

Once these are comfortable, Nested Stacks, Cross-Stack References, Stack Sets, and Stack Policies will make much more sense.
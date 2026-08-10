## 1. What is AWS CLI?

**AWS Command Line Interface (CLI)** is a command-line tool used to interact with AWS services through commands instead of the AWS Console.

```text
Terminal
   ↓
AWS CLI
   ↓
AWS APIs
   ↓
AWS Services
```

Examples:

```bash
aws s3 ls
aws ec2 describe-instances
aws iam list-users
aws ecs list-clusters
```

It is heavily used in:

* DevOps
* CI/CD pipelines
* Automation
* Shell scripting
* Troubleshooting
* Infrastructure management

---

# 2. Installation

On Ubuntu/Linux, AWS CLI v2 can be installed from the official AWS installer.

Verify:

```bash
aws --version
```

Example:

```text
aws-cli/2.x.x Python/3.x Linux/...
```

For your work, **AWS CLI v2** is the standard choice.

---

# 3. AWS CLI Basic Syntax

General syntax:

```bash
aws <service> <command> [options]
```

Example:

```bash
aws s3 ls
```

Breakdown:

```text
aws
 ↓
service = s3
 ↓
command = ls
```

Another:

```bash
aws ec2 describe-instances
```

```text
aws
 ↓
ec2
 ↓
describe-instances
```

---

# 4. AWS CLI Help

Very important when you don't remember syntax.

```bash
aws help
```

Service help:

```bash
aws ec2 help
```

Command help:

```bash
aws ec2 describe-instances help
```

You can also use:

```bash
aws ec2 describe-instances --help
```

---

# 5. AWS CLI Configuration

Configure credentials:

```bash
aws configure
```

It asks for:

```text
AWS Access Key ID
AWS Secret Access Key
Default region
Default output format
```

Example:

```text
AWS Access Key ID: ...
AWS Secret Access Key: ...
Default region: ap-south-1
Default output format: json
```

Configuration is generally stored under:

```text
~/.aws/
├── credentials
└── config
```

### Important

Don't commit:

```text
~/.aws/credentials
```

or AWS access keys into Git.

---

# 6. Check Current Identity

One of the **most useful commands**:

```bash
aws sts get-caller-identity
```

Example output:

```json
{
  "UserId": "...",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/viral"
}
```

This tells you:

* AWS Account ID
* IAM identity
* ARN

### Why useful?

Before running destructive commands:

```bash
aws sts get-caller-identity
```

You can confirm:

> "Which AWS account/identity am I currently using?"

---

# 7. AWS Regions

Check configured region:

```bash
aws configure get region
```

Specify region for a command:

```bash
aws ec2 describe-instances --region ap-south-1
```

Set default:

```bash
aws configure set region ap-south-1
```

You can list regions:

```bash
aws ec2 describe-regions
```

---

# 8. AWS CLI Profiles

Profiles are useful when working with multiple AWS accounts.

Configure:

```bash
aws configure --profile dev
```

Another:

```bash
aws configure --profile prod
```

Use:

```bash
aws s3 ls --profile dev
```

or:

```bash
aws ec2 describe-instances --profile prod
```

Set profile for the current shell:

```bash
export AWS_PROFILE=dev
```

Then:

```bash
aws sts get-caller-identity
```

will use the `dev` profile.

### Practical use

```text
AWS Account
├── dev
├── staging
└── production
```

Profiles help you avoid accidentally operating in the wrong account.

---

# 9. Output Formats

AWS CLI supports different output formats.

### JSON

```bash
aws ec2 describe-instances --output json
```

Good for:

* Automation
* APIs
* Scripts

### Table

```bash
aws ec2 describe-instances --output table
```

Good for humans.

### Text

```bash
aws ec2 describe-instances --output text
```

Useful for shell scripting.

### YAML

```bash
aws ec2 describe-instances --output yaml
```

---

# 10. JMESPath Queries

This is **very important for DevOps**.

AWS CLI can filter output using:

```bash
--query
```

Example:

```bash
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].InstanceId'
```

Output:

```text
i-0123456789
i-0987654321
```

Get instance IDs and private IPs:

```bash
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].[InstanceId,PrivateIpAddress]'
```

Example:

```text
i-123   10.0.1.10
i-456   10.0.2.10
```

This becomes extremely useful in shell scripts.

---

# 11. EC2 Commands

List instances:

```bash
aws ec2 describe-instances
```

Only running instances:

```bash
aws ec2 describe-instances \
  --filters Name=instance-state-name,Values=running
```

Get instance IDs:

```bash
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].InstanceId'
```

Start:

```bash
aws ec2 start-instances \
  --instance-ids i-123456789
```

Stop:

```bash
aws ec2 stop-instances \
  --instance-ids i-123456789
```

Reboot:

```bash
aws ec2 reboot-instances \
  --instance-ids i-123456789
```

Terminate:

```bash
aws ec2 terminate-instances \
  --instance-ids i-123456789
```

⚠️ `terminate-instances` is destructive.

---

# 12. EC2 Filtering

You can filter using:

```bash
--filters
```

Example:

```bash
aws ec2 describe-instances \
  --filters \
  "Name=instance-state-name,Values=running" \
  "Name=tag:Environment,Values=dev"
```

This finds running instances tagged:

```text
Environment=dev
```

You can combine filtering with queries:

```bash
aws ec2 describe-instances \
  --filters "Name=tag:Environment,Values=dev" \
  --query 'Reservations[].Instances[].[InstanceId,PrivateIpAddress]'
```

---

# 13. S3 Commands

List buckets:

```bash
aws s3 ls
```

List bucket contents:

```bash
aws s3 ls s3://my-bucket
```

Upload:

```bash
aws s3 cp file.txt s3://my-bucket/
```

Download:

```bash
aws s3 cp s3://my-bucket/file.txt .
```

Copy directory:

```bash
aws s3 cp ./build s3://my-bucket/ --recursive
```

Sync:

```bash
aws s3 sync ./build s3://my-bucket/
```

Download bucket:

```bash
aws s3 sync s3://my-bucket ./backup
```

Delete:

```bash
aws s3 rm s3://my-bucket/file.txt
```

Delete recursively:

```bash
aws s3 rm s3://my-bucket/ --recursive
```

⚠️ Be careful with recursive deletes.

---

# 14. `cp` vs `sync`

### `cp`

Copies specific files/directories.

```bash
aws s3 cp ./build s3://bucket/ --recursive
```

### `sync`

Synchronizes differences between source and destination.

```bash
aws s3 sync ./build s3://bucket/
```

For CI/CD deployments, `sync` is commonly useful.

Example:

```text
React build
    ↓
aws s3 sync
    ↓
S3
    ↓
CloudFront
```

---

# 15. IAM Commands

List users:

```bash
aws iam list-users
```

List roles:

```bash
aws iam list-roles
```

List policies:

```bash
aws iam list-policies
```

Get user:

```bash
aws iam get-user
```

List access keys:

```bash
aws iam list-access-keys
```

### Important security point

Avoid using long-lived IAM access keys when a better option exists.

Prefer:

```text
IAM Role
↓
Temporary credentials
↓
AWS CLI
```

For EC2, GitHub Actions, ECS, etc., roles/temporary credentials are generally preferable to hardcoded access keys.

---

# 16. VPC Commands

Describe VPCs:

```bash
aws ec2 describe-vpcs
```

Describe subnets:

```bash
aws ec2 describe-subnets
```

Describe route tables:

```bash
aws ec2 describe-route-tables
```

Describe security groups:

```bash
aws ec2 describe-security-groups
```

Describe Internet Gateways:

```bash
aws ec2 describe-internet-gateways
```

Describe NAT Gateways:

```bash
aws ec2 describe-nat-gateways
```

For troubleshooting, these commands are particularly useful.

---

# 17. Security Groups

List:

```bash
aws ec2 describe-security-groups
```

Filter by group ID:

```bash
aws ec2 describe-security-groups \
  --group-ids sg-123456
```

Security-group rules are useful when debugging:

```text
ALB → EC2
EC2 → RDS
```

For example:

```bash
aws ec2 describe-security-groups \
  --group-ids sg-123456 \
  --query 'SecurityGroups[].IpPermissions'
```

---

# 18. ECR Commands

List repositories:

```bash
aws ecr describe-repositories
```

Create repository:

```bash
aws ecr create-repository \
  --repository-name my-app
```

Login Docker to ECR:

```bash
aws ecr get-login-password --region ap-south-1 |
docker login \
  --username AWS \
  --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

Then:

```text
Docker
 ↓
Build image
 ↓
Tag image
 ↓
ECR login
 ↓
docker push
 ↓
ECR
```

List images:

```bash
aws ecr list-images \
  --repository-name my-app
```

---

# 19. ECS Commands

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

Describe task:

```bash
aws ecs describe-tasks \
  --cluster my-cluster \
  --tasks <task-id>
```

Describe service:

```bash
aws ecs describe-services \
  --cluster my-cluster \
  --services my-service
```

Force new deployment:

```bash
aws ecs update-service \
  --cluster my-cluster \
  --service my-service \
  --force-new-deployment
```

This is very useful in CI/CD.

---

# 20. CloudFormation

List stacks:

```bash
aws cloudformation list-stacks
```

Describe stack:

```bash
aws cloudformation describe-stacks \
  --stack-name my-stack
```

List stack resources:

```bash
aws cloudformation list-stack-resources \
  --stack-name my-stack
```

Although you are focusing on Terraform, knowing basic CloudFormation CLI commands is useful for AWS troubleshooting.

---

# 21. Lambda

List functions:

```bash
aws lambda list-functions
```

Invoke:

```bash
aws lambda invoke \
  --function-name my-function \
  response.json
```

View response:

```bash
cat response.json
```

Get configuration:

```bash
aws lambda get-function-configuration \
  --function-name my-function
```

---

# 22. RDS

List DB instances:

```bash
aws rds describe-db-instances
```

Specific DB:

```bash
aws rds describe-db-instances \
  --db-instance-identifier my-db
```

Start:

```bash
aws rds start-db-instance \
  --db-instance-identifier my-db
```

Stop:

```bash
aws rds stop-db-instance \
  --db-instance-identifier my-db
```

Delete:

```bash
aws rds delete-db-instance \
  --db-instance-identifier my-db \
  --skip-final-snapshot
```

⚠️ Be extremely careful with database deletion.

---

# 23. CloudWatch Logs

List log groups:

```bash
aws logs describe-log-groups
```

List streams:

```bash
aws logs describe-log-streams \
  --log-group-name /aws/my-app
```

Get logs:

```bash
aws logs get-log-events \
  --log-group-name /aws/my-app \
  --log-stream-name my-stream
```

This is useful when troubleshooting applications running on:

* EC2
* ECS
* Lambda

---

# 24. Secrets Manager

List secrets:

```bash
aws secretsmanager list-secrets
```

Get secret:

```bash
aws secretsmanager get-secret-value \
  --secret-id my-secret
```

⚠️ Be careful: printing secrets directly in terminal output or CI logs can expose credentials.

---

# 25. SSM — Systems Manager

List managed instances:

```bash
aws ssm describe-instance-information
```

Send a command:

```bash
aws ssm send-command \
  --instance-ids i-123456789 \
  --document-name "AWS-RunShellScript" \
  --parameters commands="uptime"
```

This is very useful because you can execute commands on managed EC2 instances **without SSH**, when SSM prerequisites are correctly configured.

---

# 26. Useful Global Options

Many AWS CLI commands support:

```bash
--region
--profile
--output
--query
```

Example:

```bash
aws ec2 describe-instances \
  --region ap-south-1 \
  --profile dev \
  --output table \
  --query 'Reservations[].Instances[].[InstanceId,State.Name]'
```

This is a very practical command pattern.

---

# 27. AWS CLI + Shell Scripting

This is where AWS CLI becomes particularly powerful for DevOps.

Example:

```bash
INSTANCE_ID=$(aws ec2 describe-instances \
  --filters "Name=tag:Name,Values=web-server" \
  --query 'Reservations[].Instances[0].InstanceId' \
  --output text)
```

Then:

```bash
echo "$INSTANCE_ID"
```

You can use the result in another command:

```bash
aws ec2 stop-instances --instance-ids "$INSTANCE_ID"
```

This gives you:

```text
AWS CLI
   +
Shell scripting
   ↓
Automation
```

---

# 28. AWS CLI in CI/CD

AWS CLI is commonly used inside:

* GitHub Actions
* Jenkins
* GitLab CI
* AWS CodeBuild
* Deployment scripts

Example:

```text
Git Push
   ↓
CI Pipeline
   ↓
Build
   ↓
Docker image → ECR
   ↓
ECS deployment
```

Commands could include:

```bash
aws ecr get-login-password ...
docker push ...

aws ecs update-service ...
```

Or:

```text
React Build
   ↓
aws s3 sync
   ↓
S3
   ↓
CloudFront
```

---

# 29. Credential Priority — Practical Understanding

AWS CLI can obtain credentials from several sources.

Common ones include:

```text
1. Command/environment configuration
2. Environment variables
3. AWS profile/configuration
4. IAM role credentials
```

For DevOps, the important principle is:

> **Don't hardcode AWS access keys into scripts, repositories, Dockerfiles, or CI configuration.**

Prefer temporary credentials through IAM roles/OIDC where possible.

---

# 30. Commands You Should Memorize

You don't need to memorize hundreds of AWS CLI commands.

For your DevOps internship, I would memorize these patterns:

### Identity

```bash
aws sts get-caller-identity
```

### EC2

```bash
aws ec2 describe-instances
aws ec2 start-instances
aws ec2 stop-instances
aws ec2 terminate-instances
```

### S3

```bash
aws s3 ls
aws s3 cp
aws s3 sync
aws s3 rm
```

### ECR

```bash
aws ecr describe-repositories
aws ecr get-login-password
aws ecr list-images
```

### ECS

```bash
aws ecs list-clusters
aws ecs list-services
aws ecs list-tasks
aws ecs describe-tasks
aws ecs update-service
```

### VPC

```bash
aws ec2 describe-vpcs
aws ec2 describe-subnets
aws ec2 describe-route-tables
aws ec2 describe-security-groups
aws ec2 describe-nat-gateways
```

### IAM

```bash
aws iam list-users
aws iam list-roles
aws iam list-policies
```

### Logs

```bash
aws logs describe-log-groups
aws logs describe-log-streams
```

### SSM

```bash
aws ssm describe-instance-information
aws ssm send-command
```

---

# 31. The 5 AWS CLI Concepts to Remember

If you have **very little time**, focus on these:

```text
1. aws configure / profiles
        ↓
   Authentication & accounts

2. aws sts get-caller-identity
        ↓
   Who am I?

3. --query
        ↓
   Extract exactly what you need

4. --filters
        ↓
   Find specific resources

5. CLI + shell scripting
        ↓
   Automation
```

The biggest jump from **AWS beginner → DevOps engineer** isn't memorizing every `aws` command. It's being comfortable combining:

```bash
aws ... --filters ... --query ... --output text
```

with shell variables, loops, conditions, and CI/CD pipelines.

# 1. Terraform Overview

## 1.1 What is Terraform?

Terraform is an **Infrastructure as Code (IaC)** tool developed by HashiCorp.

It allows infrastructure to be defined using configuration files instead of creating resources manually through cloud provider consoles.

Terraform can manage resources in:

- AWS
- Azure
- Google Cloud
- Kubernetes
- GitHub
- Cloudflare
- Many other platforms

Example:

Instead of manually creating an AWS VPC:

```text
AWS Console
    ↓
Create VPC
    ↓
Create Subnets
    ↓
Create Route Tables
    ↓
Create Internet Gateway
```

Terraform allows us to describe the desired infrastructure:

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```

Terraform then creates the infrastructure.

---

# 2. Advantages of Terraform

## 2.1 Infrastructure as Code

Infrastructure is written as code and stored in Git.

Benefits:

- Version control
- Code review
- Repeatability
- Easy collaboration
- Easy recovery

---

## 2.2 Declarative Approach

Terraform is primarily **declarative**.

We describe:

> "What infrastructure should exist?"

rather than:

> "Execute these commands in this exact order."

Example:

```hcl
resource "aws_s3_bucket" "app" {
  bucket = "my-example-bucket"
}
```

Terraform determines the actions required to reach this desired state.

---

## 2.3 Reproducibility

The same Terraform configuration can create similar infrastructure in:

- Development
- Testing
- Staging
- Production

Only environment-specific values need to change.

---

## 2.4 Dependency Management

Terraform automatically builds a dependency graph.

Example:

```text
VPC
 |
 +---- Subnet
        |
        +---- EC2
```

Terraform understands that the VPC must exist before the subnet and the subnet before the dependent EC2 resource.

---

## 2.5 Change Tracking

Terraform compares:

```text
Current Infrastructure
        +
Terraform Configuration
        +
Terraform State
        ↓
Required Changes
```

This makes infrastructure changes predictable.

---

# 3. Terraform Working Process

The basic Terraform workflow is:

```text
Write Configuration
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
terraform apply
        ↓
Infrastructure Created/Updated
```

When infrastructure changes:

```text
Modify .tf files
        ↓
terraform plan
        ↓
Review Changes
        ↓
terraform apply
```

---

# 4. Terraform Core Concepts

A typical Terraform project contains:

```text
terraform-project/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars
└── .terraform.lock.hcl
```

### Common files

| File | Purpose |
|---|---|
| `main.tf` | Main infrastructure resources |
| `variables.tf` | Input variable definitions |
| `outputs.tf` | Values exposed after deployment |
| `providers.tf` | Provider configuration |
| `terraform.tfvars` | Variable values |
| `.terraform.lock.hcl` | Locks provider versions |

Terraform automatically loads files ending in `.tf` in the working directory.

---

# 5. Providers

A provider allows Terraform to communicate with an external platform.

Example AWS provider:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
```

The provider translates Terraform configuration into API calls understood by AWS.

```text
Terraform
   |
   ↓
AWS Provider
   |
   ↓
AWS APIs
   |
   ↓
AWS Resources
```

---

# 6. Resources

A resource represents infrastructure that Terraform **creates or manages**.

Example:

```hcl
resource "aws_s3_bucket" "app" {
  bucket = "my-example-app-bucket"
}
```

Structure:

```text
resource "<TYPE>" "<NAME>"
```

Here:

```text
Type = aws_s3_bucket
Name = app
```

The resource can be referenced as:

```hcl
aws_s3_bucket.app
```

---

# 7. Basic Terraform Commands

## 7.1 terraform init

Initializes the Terraform working directory.

```bash
terraform init
```

It:

- Downloads providers
- Initializes modules
- Creates `.terraform`
- Creates/updates dependency lock information

Expected output:

```text
Terraform has been successfully initialized!
```

---

## 7.2 terraform validate

Checks whether the configuration is syntactically and structurally valid.

```bash
terraform validate
```

Expected:

```text
Success! The configuration is valid.
```

---

## 7.3 terraform fmt

Formats Terraform files.

```bash
terraform fmt
```

For the entire project:

```bash
terraform fmt -recursive
```

---

## 7.4 terraform plan

Shows what Terraform intends to change.

```bash
terraform plan
```

Example:

```text
+ create
~ update
- destroy
```

Important:

`plan` does **not** normally change infrastructure.

---

## 7.5 terraform apply

Applies the planned changes.

```bash
terraform apply
```

Terraform normally asks for confirmation:

```text
Do you want to perform these actions?
Enter a value: yes
```

---

## 7.6 terraform destroy

Deletes resources managed by the configuration.

```bash
terraform destroy
```

Use carefully, especially with production infrastructure.

---

## 7.7 terraform show

Displays the current state or a saved plan.

```bash
terraform show
```

---

## 7.8 terraform state list

Lists resources tracked in the Terraform state.

```bash
terraform state list
```

Example:

```text
aws_vpc.main
aws_subnet.public
aws_instance.web
```

---

# 8. Practical: Create an AWS S3 Bucket

## 8.1 Objective

Create an AWS S3 bucket using Terraform and understand the basic Terraform workflow.

## 8.2 Prerequisites

- Terraform installed
- AWS CLI installed
- AWS credentials configured
- AWS account
- Working directory

Verify Terraform:

```bash
terraform version
```

Verify AWS:

```bash
aws sts get-caller-identity
```

---

## 8.3 Create `main.tf`

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "app" {
  bucket = "my-unique-terraform-demo-bucket-12345"
}
```

The bucket name must be globally unique.

---

## 8.4 Initialize

```bash
terraform init
```

---

## 8.5 Validate

```bash
terraform validate
```

---

## 8.6 Create Plan

```bash
terraform plan
```

You should see something similar to:

```text
Plan: 1 to add, 0 to change, 0 to destroy.
```

---

## 8.7 Apply

```bash
terraform apply
```

Enter:

```text
yes
```

Terraform creates the bucket.

---

## 8.8 Verify

```bash
aws s3 ls
```

The bucket should appear.

---

## 8.9 Destroy

For a practice environment:

```bash
terraform destroy
```

Confirm with:

```text
yes
```

---

# 9. Modules

## 9.1 What is a Module?

A Terraform module is a collection of Terraform configuration files that can be reused.

The directory containing the Terraform configuration you execute directly is called the **root module**.

A module called by another module is a **child module**.

Example:

```text
terraform-project/
│
├── main.tf
│
└── modules/
    │
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

# 10. Why Use Modules?

Without modules:

```text
Project A
    ↓
Repeated VPC Code

Project B
    ↓
Repeated VPC Code

Project C
    ↓
Repeated VPC Code
```

With a module:

```text
             VPC Module
            /     |     \
           /      |      \
        Dev      QA      Prod
```

Advantages:

- Reusability
- Consistency
- Less duplication
- Easier maintenance
- Standardized infrastructure

---

# 11. Creating a Simple Module

Directory:

```text
terraform-project/
│
├── main.tf
│
└── modules/
    └── s3/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

### Module `variables.tf`

```hcl
variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}
```

### Module `main.tf`

```hcl
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}
```

### Module `outputs.tf`

```hcl
output "bucket_id" {
  description = "Created S3 bucket ID"
  value       = aws_s3_bucket.this.id
}
```

---

# 12. Calling a Module

Root `main.tf`:

```hcl
module "app_bucket" {
  source = "./modules/s3"

  bucket_name = "my-terraform-module-demo-12345"
}
```

Flow:

```text
Root Module
    |
    ↓
module "app_bucket"
    |
    ↓
modules/s3
    |
    ↓
aws_s3_bucket
```

After adding or changing a module:

```bash
terraform init
```

may be required, especially when introducing a new module source.

Then:

```bash
terraform plan
terraform apply
```

---

# 13. Data Sources

## 13.1 What is a Data Source?

A data source allows Terraform to **read existing information** without creating that resource.

Resource:

```text
Create / Manage
```

Data source:

```text
Read / Retrieve
```

---

## 13.2 Resource vs Data Source

| Resource | Data Source |
|---|---|
| Creates/manages infrastructure | Reads existing information |
| `resource` block | `data` block |
| Terraform manages lifecycle | Terraform generally does not manage lifecycle |
| Example: create VPC | Example: find existing VPC |

---

# 14. Data Source Example

Suppose a VPC already exists in AWS.

Instead of creating another VPC, retrieve it:

```hcl
data "aws_vpc" "existing" {
  id = "vpc-0123456789abcdef"
}
```

Use it:

```hcl
output "vpc_cidr" {
  value = data.aws_vpc.existing.cidr_block
}
```

Run:

```bash
terraform plan
```

Terraform reads the existing VPC information.

---

# 15. Practical Data Source Example

Find the default VPC:

```hcl
data "aws_vpc" "default" {
  default = true
}
```

Output its ID:

```hcl
output "default_vpc_id" {
  value = data.aws_vpc.default.id
}
```

Run:

```bash
terraform init
terraform plan
terraform apply
```

Example output:

```text
default_vpc_id = "vpc-0123456789abcdef"
```

No new VPC is created.

---

# 16. Variables

Variables make Terraform configurations reusable.

Without variables:

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

With variables:

```hcl
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}
```

Use:

```hcl
provider "aws" {
  region = var.aws_region
}
```

---

# 17. Variable Definition

Basic variable:

```hcl
variable "environment" {
  description = "Deployment environment"
  type        = string
}
```

Use it:

```hcl
tags = {
  Environment = var.environment
}
```

---

# 18. Ways to Provide Terraform Variables

Terraform variables can receive values from several sources.

Common methods include:

1. Variable defaults
2. `terraform.tfvars`
3. `*.auto.tfvars`
4. Environment variables
5. Command-line `-var`
6. Command-line `-var-file`

---

# 19. Variable Precedence

When the same variable is defined in multiple places, Terraform uses a precedence order.

A useful practical order from **lowest to highest precedence** is:

```text
Variable default
      ↓
terraform.tfvars
      ↓
*.auto.tfvars
      ↓
TF_VAR_* environment variables
      ↓
-var / -var-file
```

The value from the higher-precedence source wins.

---

# 20. Variable Default

```hcl
variable "environment" {
  type    = string
  default = "dev"
}
```

If nothing else provides a value:

```text
environment = dev
```

---

# 21. terraform.tfvars

Create:

```text
terraform.tfvars
```

```hcl
environment = "staging"
```

Terraform automatically loads this file.

---

# 22. auto.tfvars

Example:

```text
production.auto.tfvars
```

```hcl
environment = "production"
```

Terraform automatically loads `.auto.tfvars` files.

---

# 23. Environment Variables

Terraform recognizes environment variables using:

```text
TF_VAR_<variable_name>
```

Example:

```bash
export TF_VAR_environment="production"
```

Terraform then uses:

```text
environment = production
```

---

# 24. Command-Line Variables

Use:

```bash
terraform plan -var="environment=production"
```

Or:

```bash
terraform apply -var="environment=production"
```

---

# 25. Variable Files

You can explicitly specify a variable file:

```bash
terraform plan -var-file="production.tfvars"
```

This is useful for separate environments.

Example:

```text
dev.tfvars
qa.tfvars
prod.tfvars
```

---

# 26. Variable Precedence Example

Suppose:

### Variable default

```hcl
default = "dev"
```

### `terraform.tfvars`

```hcl
environment = "qa"
```

### Environment variable

```bash
export TF_VAR_environment="staging"
```

### CLI

```bash
terraform plan -var="environment=prod"
```

Final value:

```text
prod
```

because the CLI value has higher precedence.

---

# 27. Outputs

Outputs expose useful information from Terraform.

Example:

```hcl
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.app.bucket
}
```

After:

```bash
terraform apply
```

Terraform may display:

```text
bucket_name = "my-example-bucket"
```

---

# 28. Why Outputs Are Useful

Outputs are useful for:

- Displaying resource IDs
- Displaying IP addresses
- Passing values between modules
- Providing information to automation
- Showing connection information

Example:

```hcl
output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

---

# 29. Module Outputs

Outputs are especially important with modules.

Child module:

```hcl
output "bucket_id" {
  value = aws_s3_bucket.this.id
}
```

Root module:

```hcl
output "app_bucket_id" {
  value = module.app_bucket.bucket_id
}
```

Flow:

```text
Resource
   ↓
Child Module Output
   ↓
Root Module
   ↓
Root Output
```

---

# 30. Practical: Variables + Outputs

Create `variables.tf`:

```hcl
variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}
```

Create `main.tf`:

```hcl
resource "aws_s3_bucket" "app" {
  bucket = var.bucket_name
}
```

Create `terraform.tfvars`:

```hcl
bucket_name = "my-terraform-variable-demo-12345"
```

Create `outputs.tf`:

```hcl
output "bucket_id" {
  description = "Created bucket ID"
  value       = aws_s3_bucket.app.id
}
```

Run:

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Expected:

```text
bucket_id = "my-terraform-variable-demo-12345"
```

---

# 31. Practical Project Structure

A clean beginner Terraform project can look like:

```text
terraform-project/
│
├── main.tf
├── providers.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── modules/
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── .terraform.lock.hcl
```

Do not commit:

```text
.terraform/
terraform.tfstate
terraform.tfstate.backup
```

to a normal Git repository.

---

# 32. Terraform State

Terraform maintains a state file to track infrastructure.

Default:

```text
terraform.tfstate
```

Conceptually:

```text
Terraform Configuration
        +
Terraform State
        +
Real Infrastructure
        ↓
Terraform determines changes
```

State is extremely important and should be protected.

For team environments, use a **remote backend** rather than keeping state only on a developer's machine.

---

# 33. Important Practical Workflow

For normal Terraform development:

```bash
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
```

After making changes:

```bash
terraform plan
```

Always review the plan before applying important infrastructure changes.

---

# 34. Common Mistakes

## 34.1 Running Apply Without Reviewing Plan

Avoid blindly running:

```bash
terraform apply
```

Understand what Terraform plans to change.

---

## 34.2 Hardcoding Everything

Avoid:

```hcl
region = "ap-south-1"
```

everywhere.

Prefer variables:

```hcl
region = var.aws_region
```

where reuse is required.

---

## 34.3 Confusing Resources and Data Sources

Remember:

```text
resource → create/manage

data     → read existing information
```

---

## 34.4 Hardcoding Secrets

Never put AWS secret keys or passwords directly in `.tf` files.

Use:

- Environment variables
- AWS IAM roles
- Secret managers
- CI/CD secret stores

---

## 34.5 Ignoring State

Do not manually edit `terraform.tfstate`.

Use Terraform commands and proper state management.

---

# 35. Best Practices

- Use modules for reusable infrastructure.
- Use variables instead of unnecessary hardcoding.
- Use outputs to expose important resource information.
- Use data sources when infrastructure already exists.
- Run `terraform fmt` and `terraform validate`.
- Always review `terraform plan`.
- Use remote state for team environments.
- Lock provider versions appropriately.
- Never commit secrets.
- Protect Terraform state.
- Keep development and production configurations separated appropriately.

---

# 36. Interview Questions

## Basic

1. What is Terraform?
2. Why is Terraform called an Infrastructure as Code tool?
3. What is a Terraform provider?
4. What is a Terraform resource?
5. What is Terraform state?
6. Explain the Terraform workflow.
7. What does `terraform init` do?
8. Difference between `terraform plan` and `terraform apply`.
9. What does `terraform destroy` do?

## Modules

10. What is a Terraform module?
11. What is the difference between root and child modules?
12. Why should modules be used?
13. How do you pass values into a module?
14. How do you retrieve values from a module?

## Data Sources

15. What is a Terraform data source?
16. Difference between a resource and a data source.
17. When would you use a data source?

## Variables

18. Why are Terraform variables used?
19. What are the different ways to provide variable values?
20. Explain Terraform variable precedence.
21. What is the purpose of `TF_VAR_`?
22. What is the difference between `terraform.tfvars` and `.auto.tfvars`?

## Outputs

23. What are Terraform outputs?
24. Why are outputs useful?
25. How can a root module access a child module's output?

---

# 37. Summary

Terraform allows infrastructure to be managed using code instead of manually creating resources through cloud consoles.

The core workflow is:

```text
Write Configuration
        ↓
terraform init
        ↓
terraform validate
        ↓
terraform plan
        ↓
terraform apply
        ↓
Infrastructure
```

The most important concepts in this module are:

- **Resources** create and manage infrastructure.
- **Data Sources** read existing infrastructure information.
- **Modules** make Terraform configurations reusable.
- **Variables** make configurations flexible and environment-independent.
- **Outputs** expose useful information from resources and modules.
- **State** allows Terraform to track infrastructure.

A practical Terraform engineer should not just memorize commands. The important skill is understanding:

```text
Configuration
      +
Variables
      +
Modules
      +
Data Sources
      +
State
      ↓
Terraform Plan
      ↓
Real Infrastructure
```

That understanding becomes the foundation for building larger AWS environments using Terraform.
```
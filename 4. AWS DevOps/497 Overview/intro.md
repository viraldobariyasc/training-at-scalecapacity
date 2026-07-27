# DevOps Fundamentals

## 1. About DevOps

### What is DevOps?

DevOps is a culture, methodology, and set of practices that combines **Development (Dev)** and **Operations (Ops)** to deliver software faster, more reliably, and with better collaboration.

Instead of developers and operations teams working separately, DevOps encourages them to work together throughout the software lifecycle.

### Goals of DevOps

- Faster software delivery
- High-quality releases
- Automation of repetitive tasks
- Better collaboration
- Continuous feedback
- Reduced deployment failures
- Faster issue recovery

### DevOps Lifecycle

```text
Plan
  │
Develop
  │
Build
  │
Test
  │
Release
  │
Deploy
  │
Operate
  │
Monitor
  │
Feedback ─────► Plan
```

### Common DevOps Tools

| Stage | Tools |
|--------|------|
| Planning | Jira |
| Source Code | Git, GitHub |
| Build | Maven, Gradle |
| CI/CD | Jenkins, GitHub Actions |
| Containers | Docker |
| Orchestration | Kubernetes, Amazon ECS |
| IaC | Terraform, CloudFormation |
| Monitoring | Prometheus, Grafana, CloudWatch |

### Real-World Example

Suppose a developer fixes a payment bug.

Without DevOps:
- Developer sends code to Operations.
- Operations manually deploys.
- Deployment may fail due to environment differences.

With DevOps:
- Developer pushes code to GitHub.
- CI/CD pipeline automatically builds and tests.
- Docker image is created.
- Image is pushed to Amazon ECR.
- Amazon ECS deploys the new version.
- CloudWatch monitors the application.

---

## 2. Need of DevOps

### Problems Without DevOps

- Manual deployments
- Slow releases
- Environment mismatch ("Works on my machine")
- Communication gap
- Frequent production failures
- Difficult rollback

### How DevOps Solves Them

| Problem | Solution |
|---------|----------|
| Manual deployment | CI/CD |
| Environment mismatch | Docker |
| Manual infrastructure | Terraform |
| Slow feedback | Automated Testing |
| Downtime | Monitoring & Auto Scaling |

### Business Benefits

- Faster releases
- Better customer satisfaction
- Reduced downtime
- Lower operational cost
- Frequent feature delivery

### Technical Benefits

- Infrastructure automation
- Continuous Integration
- Continuous Deployment
- Version control
- Easy rollback
- Continuous monitoring

### Best Practices

- Automate everything possible.
- Store code in Git.
- Use Infrastructure as Code.
- Monitor applications continuously.
- Deploy small and frequent changes.

### Common Mistakes

- Manual production deployments.
- Storing secrets in code.
- No monitoring after deployment.
- Large, infrequent releases.

---

## 3. SDLC (Software Development Life Cycle)

### What is SDLC?

SDLC is a structured process used to design, develop, test, deploy, and maintain software.

### SDLC Phases

```text
Requirements
      │
Planning
      │
Design
      │
Development
      │
Testing
      │
Deployment
      │
Maintenance
```

| Phase | Purpose |
|--------|----------|
| Requirement | Understand business needs |
| Planning | Cost, timeline, resources |
| Design | Application & database design |
| Development | Coding |
| Testing | Find and fix defects |
| Deployment | Release to users |
| Maintenance | Bug fixes and enhancements |

### Real Example

Food Delivery App

- Requirement → User login, order food, payment
- Planning → Team and timeline decided
- Design → Database, APIs, UI
- Development → Developers write code
- Testing → QA verifies ordering and payment
- Deployment → Deploy to AWS ECS
- Maintenance → Add new features like coupons

---

## 4. Different SDLC Models

### Waterfall Model

Development happens sequentially.

```text
Requirement
   ↓
Design
   ↓
Development
   ↓
Testing
   ↓
Deployment
```

**Advantages**

- Easy to manage
- Well documented
- Suitable for fixed requirements

**Disadvantages**

- Difficult to change requirements
- Testing happens late
- Slow delivery

**Best For**

- Government projects
- Banking software
- Fixed-scope applications

---

### Agile Model

Development is divided into short iterations called **Sprints**.

```text
Sprint 1
   ↓
Release
   ↓
Sprint 2
   ↓
Release
```

Typical Sprint: **2–4 weeks**

### Agile Principles

- Customer collaboration
- Frequent releases
- Continuous improvement
- Respond to changing requirements

### Scrum Roles

| Role | Responsibility |
|------|----------------|
| Product Owner | Defines product requirements |
| Scrum Master | Removes blockers and manages Scrum |
| Development Team | Builds the application |

### Agile Advantages

- Faster delivery
- Continuous feedback
- Easier requirement changes
- Lower project risk

### Agile Disadvantages

- Requires active customer involvement
- Scope may change frequently

---

## Agile vs Waterfall

| Feature | Waterfall | Agile |
|----------|-----------|--------|
| Process | Sequential | Iterative |
| Requirement Changes | Difficult | Easy |
| Delivery | One Time | Frequent |
| Testing | End | Continuous |
| Customer Feedback | Final Stage | Every Sprint |
| Best For | Fixed Scope | Dynamic Projects |

---

## DevOps + Agile

Agile helps teams **develop software faster**.

DevOps helps teams **build, test, deploy, and monitor software automatically**.

Together they enable Continuous Delivery.

---

# Practical

## Objective

Understand how DevOps improves software delivery.

## Scenario

Deploy a Spring Boot application using AWS.

### Workflow

1. Push code to GitHub.
2. GitHub Actions/Jenkins builds the application.
3. Run unit tests.
4. Build Docker image.
5. Push image to Amazon ECR.
6. Deploy image to Amazon ECS.
7. Monitor logs in CloudWatch.

### Verification

- Pipeline succeeds.
- Docker image exists in ECR.
- ECS service is healthy.
- Application is accessible.

### Expected Outcome

Application is deployed automatically with minimal manual effort.

---

# Extra Topics

## 1. CI/CD

CI (Continuous Integration):
Developers frequently merge code into a shared repository where builds and tests run automatically.

CD (Continuous Delivery/Deployment):
Automatically delivers tested applications to staging or production.

**Example:** GitHub → GitHub Actions → ECR → ECS

---

## 2. Infrastructure as Code (IaC)

Infrastructure is defined using code instead of manual AWS Console actions.

Popular tools:
- Terraform
- AWS CloudFormation

**Benefit:** Same infrastructure can be recreated anytime.

---

## 3. DevSecOps

Integrates security throughout the DevOps lifecycle.

Examples:
- Code scanning
- Dependency scanning
- Secret detection
- Container image scanning (Trivy)

---

## 4. GitOps

Infrastructure and Kubernetes deployments are managed through Git.

Example:
Developer updates Kubernetes YAML in Git → ArgoCD detects changes → Cluster updates automatically.

---

## 5. Monitoring & Observability

Used to detect issues before users report them.

Common tools:
- Amazon CloudWatch
- Prometheus
- Grafana

Metrics monitored:
- CPU
- Memory
- Errors
- Response Time

---

# Interview Questions with Answers

### Q1. What is DevOps?

**Answer:** DevOps is a culture and set of practices that improves collaboration between Development and Operations using automation, enabling faster and more reliable software delivery.

---

### Q2. Why is DevOps needed?

**Answer:** To automate deployments, reduce manual errors, improve collaboration, deliver software faster, and increase system reliability.

---

### Q3. What is SDLC?

**Answer:** SDLC is the structured process of developing software from requirement gathering to maintenance.

---

### Q4. Difference between Agile and Waterfall?

**Answer:**
- Waterfall follows a sequential process with fixed requirements.
- Agile follows iterative development with continuous feedback and frequent releases.

---

### Q5. How does DevOps complement Agile?

**Answer:** Agile focuses on developing software quickly, while DevOps automates building, testing, deployment, and monitoring, enabling continuous delivery.

---

### Q6. Give a real-world DevOps example.

**Answer:** A developer pushes code to GitHub. GitHub Actions builds the application, runs tests, creates a Docker image, pushes it to Amazon ECR, deploys it to Amazon ECS, and CloudWatch monitors the application.

---

# Summary

- DevOps combines Development and Operations through automation and collaboration.
- DevOps enables faster, reliable, and frequent software delivery.
- SDLC provides a structured software development process.
- Waterfall suits stable projects, while Agile suits rapidly changing projects.
- CI/CD, IaC, DevSecOps, GitOps, and Monitoring are core DevOps practices.
- In AWS, a typical DevOps workflow uses GitHub, GitHub Actions/Jenkins, Docker, Amazon ECR, Amazon ECS/EKS, Terraform, and CloudWatch.
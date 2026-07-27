# SDLC Models (Software Development Life Cycle)

## 1. Introduction

An **SDLC (Software Development Life Cycle) model** defines the process a software development team follows to plan, design, develop, test, deploy, and maintain software.

There is **no universally best SDLC model**. The choice depends on factors such as project size, complexity, customer involvement, budget, and changing requirements.

---

# 2. Waterfall Model

## Overview

The Waterfall model is a **linear and sequential** SDLC model where each phase must be completed before moving to the next.

```
Requirements
      ↓
Design
      ↓
Development
      ↓
Testing
      ↓
Deployment
      ↓
Maintenance
```

## Characteristics

- Sequential process
- Documentation-heavy
- Requirements are fixed before development starts
- Minimal customer involvement after requirement gathering

## Advantages

- Simple and easy to understand
- Well-defined phases
- Easy to manage
- Suitable for small projects with fixed requirements

## Disadvantages

- Difficult to accommodate changes
- Testing occurs late
- High cost of fixing defects discovered late
- Not suitable for dynamic projects

## Real-World Example

Developing software for government or banking systems where requirements are clearly defined and rarely change.

---

# 3. Agile Model

## Overview

Agile is an **iterative and incremental** SDLC model where software is developed in small, frequent releases called **iterations** or **sprints**.

```
Planning
    ↓
Development
    ↓
Testing
    ↓
Review
    ↓
Next Sprint
```

## Characteristics

- Short development cycles (usually 2–4 weeks)
- Frequent customer feedback
- Continuous improvements
- Flexible to changing requirements

## Advantages

- Faster delivery
- Easy to adapt to changes
- Continuous customer involvement
- Early detection of issues

## Disadvantages

- Less predictable timeline
- Requires experienced teams
- Continuous customer participation is needed

## Real-World Example

Developing an e-commerce application where new features are added regularly based on customer feedback.

---

# 4. Scrum Model

## Overview

Scrum is the **most widely used Agile framework**.

Work is divided into **Sprints**, typically lasting **2 to 4 weeks**.

## Scrum Roles

- Product Owner
- Scrum Master
- Development Team

## Scrum Events

- Sprint Planning
- Daily Stand-up
- Sprint Review
- Sprint Retrospective

## Advantages

- High transparency
- Frequent releases
- Continuous feedback
- Better team collaboration

## Best For

Projects where requirements change frequently.

---

# 5. Spiral Model

## Overview

The Spiral model combines **Waterfall and Prototyping** with a strong focus on **risk analysis**.

```
Planning
      ↓
Risk Analysis
      ↓
Development
      ↓
Testing
      ↓
Repeat
```

## Characteristics

- Risk-driven approach
- Multiple iterations
- Suitable for large and complex projects

## Advantages

- Early identification of risks
- Flexible
- Better quality

## Disadvantages

- Expensive
- Complex to manage
- Requires experienced teams

## Best For

Large enterprise, banking, defense, or aerospace projects.

---

# 6. V-Model (Verification & Validation)

## Overview

The V-Model is an extension of the Waterfall model where each development phase has a corresponding testing phase.

```
Requirements      ←→ Acceptance Testing

System Design     ←→ System Testing

Architecture      ←→ Integration Testing

Module Design     ←→ Unit Testing

          Coding
```

## Advantages

- Testing starts early
- High quality
- Easy defect tracking

## Disadvantages

- Difficult to handle requirement changes
- Less flexible

## Best For

Medical systems, automotive software, and safety-critical applications.

---

# 7. Iterative Model

## Overview

The software is developed through multiple iterations.

Each iteration adds new features.

```
Iteration 1
     ↓

Iteration 2
     ↓

Iteration 3
     ↓

Final Product
```

## Advantages

- Early working software
- Easy to improve
- Lower project risk

## Disadvantages

- Requires good planning
- Architecture must support future changes

## Best For

Projects where requirements evolve over time.

---

# 8. Incremental Model

## Overview

The application is developed in **small functional modules (increments)**.

Example:

```
Version 1
Login

↓

Version 2
Dashboard

↓

Version 3
Payment

↓

Version 4
Reports
```

Each release delivers usable functionality.

## Advantages

- Faster delivery
- Easy testing
- Lower risk
- Customer gets usable software early

## Disadvantages

- Requires good architecture
- Integration can become complex

## Best For

SaaS products and web applications.

---

# 9. DevOps Model

## Overview

DevOps extends Agile by integrating **Development (Dev)** and **Operations (Ops)**.

```
Plan

↓

Develop

↓

Build

↓

Test

↓

Release

↓

Deploy

↓

Monitor

↓

Feedback
```

## Characteristics

- Continuous Integration (CI)
- Continuous Delivery/Deployment (CD)
- Automation
- Infrastructure as Code
- Monitoring

## Advantages

- Faster deployments
- Reduced manual work
- Better collaboration
- Quick issue detection
- Continuous improvement

## Common DevOps Tools

| Stage | Examples |
|--------|----------|
| Source Control | Git, GitHub |
| CI | GitHub Actions, Jenkins, AWS CodeBuild |
| Containerization | Docker |
| Orchestration | Kubernetes, Amazon ECS |
| Infrastructure | Terraform |
| Monitoring | Prometheus, Grafana, CloudWatch |

---

# 10. Comparison Table

| Model | Flexibility | Customer Involvement | Best For | Major Drawback |
|--------|-------------|----------------------|----------|----------------|
| Waterfall | Low | Low | Fixed requirements | Difficult to change |
| Agile | High | High | Dynamic projects | Requires active collaboration |
| Scrum | High | Very High | Product development | Needs disciplined teams |
| Spiral | High | Medium | Large, high-risk projects | Expensive |
| V-Model | Low | Low | Safety-critical software | Poor flexibility |
| Iterative | Medium | Medium | Gradually evolving systems | Requires planning |
| Incremental | High | Medium | SaaS/Web applications | Integration complexity |
| DevOps | Very High | Continuous Feedback | Modern cloud applications | Requires automation expertise |

---

# 11. Which Model is Used Today?

| Industry | Common SDLC Model |
|----------|-------------------|
| Startups | Agile + DevOps |
| Product Companies | Scrum + DevOps |
| Banking | Agile / Spiral |
| Government Projects | Waterfall |
| Healthcare | V-Model |
| Cloud & SaaS | Agile + DevOps |
| Enterprise Applications | Agile + DevOps |

---

# 12. Interview Questions

1. What is an SDLC model?
2. Why are different SDLC models needed?
3. What is the difference between Waterfall and Agile?
4. When would you choose the Spiral model?
5. What is Scrum, and how is it related to Agile?
6. Why is the V-Model suitable for safety-critical applications?
7. Difference between Iterative and Incremental models.
8. Why has DevOps become the preferred approach for modern software development?
9. Which SDLC model is most commonly used in startups and product-based companies?
10. Can Agile and DevOps be used together? Explain.

---

# 13. Key Takeaways

- **Waterfall** → Best for projects with fixed and well-defined requirements.
- **Agile** → Best for projects with frequently changing requirements.
- **Scrum** → The most popular Agile framework using short sprints.
- **Spiral** → Ideal for large, complex, and high-risk projects.
- **V-Model** → Focuses on early testing and quality assurance.
- **Iterative** → Builds the product through repeated improvements.
- **Incremental** → Delivers software feature by feature.
- **DevOps** → Extends Agile by automating build, test, deployment, and monitoring for faster and more reliable software delivery.
# 1. Understand the Scalability & High Availability

## 1.1 What is Scalability?

Scalability is the ability of an application to handle increasing or decreasing workloads by adjusting resources.

Example:
- An e-commerce website receives 100 users normally.
- During a sale, it receives 10,000 users.
- The infrastructure should be able to handle the increased traffic without crashing.

---

## 1.2 What is High Availability?

High Availability (HA) means the application remains accessible even if one server or Availability Zone fails.

AWS achieves High Availability by distributing resources across multiple Availability Zones.

Example:

```
Users
   │
Application Load Balancer
   │
───────────────
│             │
EC2 (AZ-A)   EC2 (AZ-B)
```

If one instance or AZ fails, traffic is automatically sent to the healthy instance.

---

## 1.3 Scalability vs High Availability

| Scalability | High Availability |
|-------------|-------------------|
| Handles increased workload | Reduces downtime |
| Adds or removes resources | Uses redundant resources |
| Focuses on performance | Focuses on reliability |

---

# 2. Vertical Scalability v/s Horizontal Scalability

## 2.1 Vertical Scalability (Scaling Up)

Increase the resources of an existing server.

Example:

```
2 vCPU, 4 GB RAM
        ↓
8 vCPU, 16 GB RAM
```

### Advantages

- Easy to implement.
- No application changes required.

### Disadvantages

- Limited by hardware.
- Downtime may be required.

---

## 2.2 Horizontal Scalability (Scaling Out)

Increase the number of servers instead of increasing server size.

Example:

```
Before

EC2

After

EC2
EC2
EC2
EC2
```

### Advantages

- Better fault tolerance.
- High Availability.
- Can scale almost infinitely.

### Disadvantages

- Requires a Load Balancer.
- Slightly more complex.

---

## 2.3 Difference

| Vertical Scaling | Horizontal Scaling |
|------------------|--------------------|
| Increase server size | Increase server count |
| Limited growth | Almost unlimited growth |
| May require downtime | No downtime in most cases |
| Single machine | Multiple machines |

---

# 3. Load Balancing & its Need

## 3.1 What is Load Balancing?

A Load Balancer distributes incoming requests across multiple servers.

Instead of sending all requests to one server, it shares the workload.

```
Users
   │
Load Balancer
   │
───────────────
│      │      │
EC2    EC2    EC2
```

---

## 3.2 Why is Load Balancing Needed?

- Prevent server overload.
- Improve availability.
- Improve performance.
- Increase fault tolerance.
- Support Auto Scaling.

---

# 4. Types of Load Balancer (ALB, NLB & GLB)

AWS provides three main Load Balancers.

---

## 4.1 Application Load Balancer (ALB)

Works at **Layer 7 (HTTP/HTTPS)**.

Supports:

- Path-based routing
- Host-based routing
- Microservices
- Containers

Example:

```
example.com/api
      │
Backend Service

example.com/images
      │
Image Service
```

---

## 4.2 Network Load Balancer (NLB)

Works at **Layer 4 (TCP/UDP)**.

Used when:

- Extremely high performance is required.
- Low latency is important.
- Static IP is required.

Examples:

- Gaming
- Financial systems
- VoIP

---

## 4.3 Gateway Load Balancer (GLB)

Used for deploying and managing network security appliances.

Examples:

- Firewalls
- Intrusion Detection Systems
- Security appliances

---

## 4.4 Comparison

| ALB | NLB | GLB |
|-----|-----|-----|
| Layer 7 | Layer 4 | Layer 3 |
| HTTP/HTTPS | TCP/UDP | Security Appliances |
| Path Routing | Very Fast | Network Inspection |

---

# 5. Application Load Balancer

An ALB distributes HTTP and HTTPS requests to healthy targets.

### Features

- Path-based routing.
- Host-based routing.
- SSL termination.
- Health checks.
- Supports WebSockets.
- Integrates with Auto Scaling Groups.

---

# 6. Target Groups

A Target Group contains the resources that receive traffic from a Load Balancer.

Targets can be:

- EC2 Instances
- IP Addresses
- Lambda Functions

Example:

```
ALB
 │
Target Group
 │
─────────────
│     │     │
EC2   EC2   EC2
```

Only healthy targets receive requests.

---

# 7. Auto Scaling Groups

An Auto Scaling Group (ASG) automatically launches or terminates EC2 instances based on demand.

Example:

```
Users Increase
      │
CPU > 70%
      │
Auto Scaling Group
      │
Launch New EC2
```

Benefits:

- Automatic scaling.
- High Availability.
- Cost optimization.
- Self-healing.

---

# 8. Launch Templates

A Launch Template defines how new EC2 instances should be created.

It contains:

- AMI
- Instance Type
- Key Pair
- Security Group
- IAM Role
- User Data
- Storage configuration

Whenever ASG launches a new instance, it uses the Launch Template.

---

# 9. Types of Scaling Policies

AWS supports multiple scaling policies.

---

## 9.1 Target Tracking Scaling

Automatically adjusts capacity to maintain a target metric.

Example:

Maintain CPU utilization at **50%**.

---

## 9.2 Step Scaling

Scale based on different thresholds.

Example:

- CPU > 60% → Add 1 instance.
- CPU > 80% → Add 2 instances.

---

## 9.3 Simple Scaling

Performs a single scaling action and waits for a cooldown period before another action.

---

## 9.4 Scheduled Scaling

Scale resources at a specific time.

Example:

Increase capacity every weekday at 9:00 AM.

---

# 10. Practical

## Objective

Create an Auto Scaling Group with an Application Load Balancer.

---

## Prerequisites

- AWS Account
- Existing VPC
- Public Subnets in at least two Availability Zones
- Security Group
- Launch Template

---

## Steps

### Create a Launch Template

1. Open EC2 Console.
2. Select **Launch Templates**.
3. Click **Create Launch Template**.
4. Select AMI.
5. Choose Instance Type.
6. Select Key Pair.
7. Attach Security Group.
8. Save the template.

---

### Create an Application Load Balancer

1. Open **Load Balancers**.
2. Click **Create Load Balancer**.
3. Choose **Application Load Balancer**.
4. Select VPC and two public subnets.
5. Create a Target Group.
6. Register targets.
7. Create the ALB.

---

### Create an Auto Scaling Group

1. Open **Auto Scaling Groups**.
2. Click **Create Auto Scaling Group**.
3. Select the Launch Template.
4. Choose the VPC.
5. Attach the Target Group.
6. Set minimum, desired, and maximum capacity.
7. Configure Target Tracking Scaling.
8. Create the ASG.

---

## Verification

- Access the application using the ALB DNS name.
- Increase CPU load on an EC2 instance.
- Observe new instances being launched automatically.
- Stop one instance and verify traffic is redirected to healthy instances.

---

# 11. Extra Topics

## 11.1 Health Checks

Health checks monitor whether an instance is healthy.

If an instance fails the health check:

- ALB stops sending traffic.
- Auto Scaling Group can replace it automatically.

---

## 11.2 Cross Zone Load Balancing

Allows the Load Balancer to distribute traffic evenly across all registered instances, regardless of the Availability Zone.

---

## 11.3 Sticky Sessions

Also called **Session Affinity**.

Ensures requests from the same user are routed to the same backend instance for a specified duration.

Useful for applications that store session data locally.

---

## 11.4 Listener & Listener Rules

A Listener checks incoming requests on a specific port (e.g., 80 or 443).

Listener Rules determine where the request should be forwarded.

Example:

```
/api/*     → Backend API

/images/*  → Image Server
```

---

## 11.5 Dynamic Scaling vs Predictive Scaling

| Dynamic Scaling | Predictive Scaling |
|-----------------|--------------------|
| Reacts to current metrics | Predicts future demand |
| Uses CPU, memory, etc. | Uses historical usage patterns |
| Good for unexpected traffic | Good for recurring traffic patterns |

---

# 12. Interview Questions

### Q1. What is the difference between Scalability and High Availability?

Scalability increases system capacity to handle more traffic, whereas High Availability ensures the application remains accessible even during failures.

---

### Q2. What is the difference between Vertical and Horizontal Scaling?

Vertical Scaling increases the resources of a single server, while Horizontal Scaling increases the number of servers.

---

### Q3. Which Load Balancer is used for HTTP/HTTPS traffic?

Application Load Balancer (ALB).

---

### Q4. What is the purpose of a Target Group?

A Target Group contains the backend resources that receive requests from the Load Balancer.

---

### Q5. What is the purpose of a Launch Template?

It stores the EC2 configuration that Auto Scaling Groups use to launch new instances.

---

### Q6. Which scaling policy automatically maintains a target CPU utilization?

Target Tracking Scaling.

---

# 13. Summary

- Scalability helps applications handle changing workloads.
- High Availability minimizes downtime by using redundant resources.
- ALB distributes HTTP/HTTPS traffic, NLB handles TCP/UDP traffic, and GLB is used for network security appliances.
- Target Groups connect Load Balancers to backend resources.
- Auto Scaling Groups automatically adjust EC2 capacity.
- Launch Templates standardize EC2 configuration.
- Scaling Policies automate how and when infrastructure scales.
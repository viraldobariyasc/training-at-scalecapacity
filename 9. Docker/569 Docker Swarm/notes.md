# Docker Swarm Notes

## 1. What is Docker Swarm?

Docker Swarm is Docker's **built-in container orchestration** technology.

It allows multiple Docker hosts to work together as a **single cluster**.

It provides features such as:

- Container deployment
- Scaling
- Load balancing
- Service discovery
- Rolling updates
- Self-healing

```text
              Docker Swarm Cluster
                     |
          +----------+----------+
          |                     |
     Manager Node          Worker Node
          |                     |
      Services              Containers
```

---

## 2. Swarm Architecture

A Swarm cluster mainly contains:

### Manager Node

The manager is responsible for:

- Managing the cluster
- Scheduling services
- Maintaining desired state
- Managing worker nodes

### Worker Node

Workers run the containers/tasks assigned by managers.

```text
              Manager
                 |
        +--------+--------+
        |                 |
     Worker 1          Worker 2
        |                 |
    Containers        Containers
```

A node can also act as both a manager and worker.

---

## 3. Important Concepts

| Concept | Meaning |
|---|---|
| Swarm | Cluster of Docker nodes |
| Manager | Manages the cluster |
| Worker | Runs assigned tasks |
| Service | Desired state of an application |
| Task | Individual container instance |
| Stack | Multiple services deployed together |

### Service vs Container

In normal Docker:

```text
docker run → Container
```

In Swarm:

```text
docker service create → Service
                              |
                         Tasks/Containers
```

---

## 4. Create a Swarm

Initialize Swarm on the manager:

```bash
docker swarm init
```

Example output:

```text
Swarm initialized: current node is now a manager.
```

The command also provides a `docker swarm join` command that worker nodes can use to join the cluster.

Check nodes:

```bash
docker node ls
```

---

## 5. Create a Service

Example:

```bash
docker service create --name web --publish 8080:80 --replicas 3 nginx
```

This creates an Nginx service with **3 replicas**.

Check services:

```bash
docker service ls
```

Check tasks:

```bash
docker service ps web
```

```text
             web service
                 |
        +--------+--------+
        |        |        |
      Task 1   Task 2   Task 3
        |        |        |
      Nginx    Nginx    Nginx
```

---

## 6. Scaling

One important advantage of Swarm is easy service scaling.

Scale from 3 to 5 replicas:

```bash
docker service scale web=5
```

Check:

```bash
docker service ps web
```

Swarm creates additional tasks to reach the desired state.

---

## 7. Rolling Updates

Swarm can update services gradually instead of replacing everything at once.

Example:

```bash
docker service update --image nginx:latest web
```

Swarm updates the service according to its update configuration.

This helps reduce application downtime.

---

## 8. Self-Healing

Swarm maintains the desired number of replicas.

For example:

```text
Desired replicas = 3

Running:
Container 1
Container 2
Container 3
```

If one fails:

```text
Container 1
Container 2
Container 3 → Failed
```

Swarm attempts to create another task:

```text
Container 1
Container 2
Container 4
```

The goal is to return to the desired state of 3 replicas.

---

## 9. Practical

### Objective

Create a single-node Swarm and deploy an Nginx service with multiple replicas.

### Step 1: Initialize Swarm

```bash
docker swarm init
```

### Step 2: Check Nodes

```bash
docker node ls
```

Expected:

```text
HOSTNAME    STATUS    MANAGER STATUS
docker      Ready     Leader
```

### Step 3: Create Service

```bash
docker service create \
  --name web \
  --publish 8080:80 \
  --replicas 3 \
  nginx
```

### Step 4: Verify

```bash
docker service ls
```

Expected:

```text
NAME   MODE        REPLICAS   IMAGE
web    replicated  3/3        nginx:latest
```

Check tasks:

```bash
docker service ps web
```

### Step 5: Scale

```bash
docker service scale web=5
```

Verify:

```bash
docker service ls
```

You should see:

```text
5/5
```

### Step 6: Remove Service

```bash
docker service rm web
```

**Screenshot:** Add a screenshot of `docker node ls`, `docker service ls`, and `docker service ps web`.

---

## 10. Docker Swarm vs Kubernetes

| Feature | Docker Swarm | Kubernetes |
|---|---|---|
| Complexity | Simpler | More complex |
| Setup | Easier | More involved |
| Docker integration | Native | Supports container runtimes |
| Scaling | Yes | Yes |
| Self-healing | Yes | Yes |
| Ecosystem | Smaller | Much larger |
| Common enterprise usage | Less common | Very common |

For modern DevOps roles, **Kubernetes is generally more important to learn deeply**, but understanding Swarm helps explain the fundamentals of container orchestration.

---

## 11. Common Commands

```bash
docker swarm init
docker node ls
docker swarm join
docker service create
docker service ls
docker service ps
docker service scale
docker service update
docker service rm
docker swarm leave
```

---

## 12. Common Mistakes

- Trying to run Swarm service commands before initializing a Swarm.
- Confusing Docker containers with Swarm services/tasks.
- Forgetting to publish the required port.
- Not checking service tasks when a replica is not running.
- Removing a node without understanding its role in the cluster.

---

## 13. Interview Questions

1. What is Docker Swarm?
2. What is the difference between a manager and worker node?
3. What is a Swarm service?
4. What is a task in Docker Swarm?
5. How do you scale a Swarm service?
6. How does Swarm provide self-healing?
7. What is the difference between Docker Swarm and Kubernetes?
8. How do you initialize a Swarm cluster?

---

## 14. Summary

- Docker Swarm is Docker's native container orchestration technology.
- A Swarm consists of manager and worker nodes.
- Managers maintain the desired state.
- Workers run tasks.
- Services define how applications should run.
- Swarm supports scaling, load balancing, rolling updates, and self-healing.
- Kubernetes is more widely used for large-scale modern container orchestration.
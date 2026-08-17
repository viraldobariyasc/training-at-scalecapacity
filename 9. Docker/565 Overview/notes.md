# Docker Overview Notes

## 1. What is Docker?

Docker is a platform used to **build, package, and run applications in containers**.

A container packages an application together with its required dependencies so it can run consistently across different environments.

```text
Application
    +
Dependencies
    +
Configuration
    |
    v
 Docker Image
    |
    v
Container
```

### 1.1 Why Docker?

Without Docker:

```text
Developer Machine
     |
     | "It works on my machine!"
     v
Different Server
     |
     X
Different environment/dependencies
```

With Docker:

```text
Docker Image
     |
     +----> Developer Machine
     |
     +----> Testing Server
     |
     +----> Production Server
```

The same image can be used across environments.

---

## 2. Containers

A **container** is a running instance of a Docker image.

For example:

```text
Docker Image
     |
     +----> Container 1
     |
     +----> Container 2
```

Multiple containers can be created from the same image.

Containers are:

- Lightweight
- Isolated
- Fast to start
- Portable
- Easy to create and remove

---

## 3. Docker Image

A **Docker image** is a read-only template used to create containers.

Example:

```text
Ubuntu Image
     |
     +----> Container 1
     +----> Container 2
```

An image can contain:

- Application code
- Runtime
- Libraries
- Dependencies
- Configuration

Images are commonly created using a **Dockerfile**.

---

## 4. Docker Architecture

```text
                Docker Client
                     |
                  Docker API
                     |
              Docker Engine
                     |
        +------------+------------+
        |            |            |
     Images      Containers     Volumes
        |
        v
   Docker Registry
   (Docker Hub etc.)
```

Important components:

| Component | Purpose |
|---|---|
| Docker Client | Used to run Docker commands |
| Docker Engine | Runs and manages containers |
| Image | Template for containers |
| Container | Running application environment |
| Registry | Stores Docker images |
| Volume | Stores persistent data |

---

## 5. Docker vs Virtual Machine

| Docker Container | Virtual Machine |
|---|---|
| Shares host OS kernel | Has its own guest OS |
| Lightweight | Heavier |
| Starts quickly | Usually slower |
| Uses fewer resources | Uses more resources |
| Container-level isolation | Full OS virtualization |

```text
Virtual Machines

Hardware
   |
Hypervisor
   |
+---------+---------+
| Guest OS| Guest OS|
|  App    |  App    |
+---------+---------+


Docker

Hardware
   |
Host OS
   |
Docker Engine
   |
+---------+---------+
|Container|Container|
|   App   |   App   |
+---------+---------+
```

---

## 6. Common Docker Use Cases

Docker is commonly used for:

- Application development
- Testing
- CI/CD pipelines
- Microservices
- Application deployment
- Local development environments
- Packaging applications with dependencies

Example DevOps workflow:

```text
Developer
    |
    v
Dockerfile
    |
    v
Docker Image
    |
    v
Container
    |
    v
Docker Registry
    |
    v
Production Server
```

---

## 7. Basic Docker Workflow

```text
Write Dockerfile
       |
       v
Build Image
       |
       v
Run Container
       |
       v
Test Application
       |
       v
Push Image to Registry
       |
       v
Deploy Container
```

---

## 8. Important Terms

| Term | Meaning |
|---|---|
| Image | Template used to create containers |
| Container | Running instance of an image |
| Dockerfile | Instructions for building an image |
| Docker Engine | Runtime that manages containers |
| Registry | Repository for Docker images |
| Docker Hub | Public Docker image registry |
| Volume | Persistent storage for containers |

---

## 9. Interview Questions

1. What is Docker?
2. Why is Docker used?
3. What is a container?
4. What is a Docker image?
5. What is the difference between an image and a container?
6. Docker container vs Virtual Machine?
7. What is a Dockerfile?
8. What is Docker Hub?
9. What is Docker Engine?

---

## 10. Summary

- Docker is used to package and run applications in containers.
- **Image** → Template.
- **Container** → Running instance of an image.
- **Dockerfile** → Instructions used to build an image.
- Containers are lightweight and portable.
- Docker is widely used in development, CI/CD, microservices, and cloud deployments.
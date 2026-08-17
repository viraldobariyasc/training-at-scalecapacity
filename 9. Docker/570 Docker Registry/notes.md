# Docker Registry Notes

## 1. What is a Docker Registry?

A **Docker Registry** is a place where Docker images are stored and shared.

Think of it like **GitHub, but for Docker images**.

```text
Developer
    |
    | docker push
    v
Docker Registry
    |
    | docker pull
    v
Server
```

Examples:

- Docker Hub
- Amazon ECR
- GitHub Container Registry
- Azure Container Registry

---

## 2. Docker Hub

Docker Hub is a public Docker registry.

It contains many ready-to-use images:

```text
nginx
ubuntu
redis
postgres
node
```

Pull an image:

```bash
docker pull nginx
```

Docker automatically looks for the image in Docker Hub if no registry is specified.

---

## 3. Image Tags

Tags identify different versions of an image.

Example:

```text
nginx:latest
nginx:1.27
```

Format:

```text
image-name:tag
```

Example:

```bash
docker pull nginx:1.27
```

For production, prefer specific versions instead of relying on `latest`.

---

## 4. Push an Image

First, build an image:

```bash
docker build -t myapp .
```

Tag it with your Docker Hub username:

```bash
docker tag myapp username/myapp:1.0
```

Login:

```bash
docker login
```

Push:

```bash
docker push username/myapp:1.0
```

Now the image is available in your registry repository.

---

## 5. Pull Your Image

On another machine:

```bash
docker pull username/myapp:1.0
```

Then run it:

```bash
docker run username/myapp:1.0
```

```text
Machine A
    |
docker build
    |
    v
Image
    |
docker push
    |
    v
Docker Registry
    |
docker pull
    |
    v
Machine B
    |
docker run
```

---

## 6. Public vs Private Registry

| Public Registry | Private Registry |
|---|---|
| Images may be publicly accessible | Access is controlled |
| Easy to share | Better for company applications |
| Example: public Docker Hub repository | Example: private ECR/ACR repository |

Private registries are commonly used for proprietary application images.

---

## 7. Practical

### Objective

Build an image, tag it correctly, and understand the push workflow.

### Step 1: Build

```bash
docker build -t myapp .
```

### Step 2: Tag

```bash
docker tag myapp username/myapp:1.0
```

Verify:

```bash
docker images
```

Expected:

```text
REPOSITORY       TAG
myapp            latest
username/myapp   1.0
```

### Step 3: Login

```bash
docker login
```

Enter your registry credentials.

### Step 4: Push

```bash
docker push username/myapp:1.0
```

### Step 5: Pull

On another machine:

```bash
docker pull username/myapp:1.0
```

**Screenshot:** Add screenshots of `docker images`, successful `docker login`, and `docker push`.

---

## 8. AWS Example: Amazon ECR

In AWS environments, **Amazon ECR** is commonly used as a private container registry.

Typical CI/CD flow:

```text
Developer
    |
    v
GitHub
    |
    v
CI/CD Pipeline
    |
    v
Docker Build
    |
    v
Amazon ECR
    |
    v
ECS / EKS
```

The important idea is:

**Build image → Push image to registry → Deployment platform pulls image.**

---

## 9. Best Practices

- Use meaningful image tags such as `1.0.0` or Git commit SHA.
- Avoid using only `latest` in production.
- Keep private application images in private registries.
- Scan images for vulnerabilities.
- Don't put passwords or secrets inside images.
- Use authentication when accessing private registries.

---

## 10. Common Mistakes

- Forgetting to tag the image with the registry/repository name.
- Pushing to the wrong repository.
- Not logging in to a private registry.
- Using `latest` for production deployments without controlling what it points to.
- Accidentally making private application images public.

---

## 11. Interview Questions

1. What is a Docker Registry?
2. What is Docker Hub?
3. What is the difference between a Docker image and a registry?
4. Why do we tag Docker images?
5. How do you push an image to Docker Hub?
6. What is a private registry?
7. Why are private registries used in companies?
8. What is Amazon ECR?
9. Why should production images use specific tags?

---

## 12. Summary

- **Docker Registry** stores and distributes Docker images.
- **Docker Hub** is a popular public registry.
- `docker push` uploads an image.
- `docker pull` downloads an image.
- Image tags identify versions.
- Private registries are commonly used for company applications.
- AWS provides **Amazon ECR** for private container images.

```text
Build
  |
  v
Image
  |
  | docker push
  v
Registry
  |
  | docker pull
  v
Server
  |
  v
Container
```
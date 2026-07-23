# 1. Invoking REST APIs using Shell Script

Most modern applications communicate using **REST APIs**. Shell scripts can invoke these APIs to automate tasks such as deployments, triggering pipelines, retrieving data, and managing cloud resources.

---

# 1.1 What is a REST API?

A **REST (Representational State Transfer) API** is a web service that allows applications to communicate with each other over HTTP.

Instead of interacting with a user interface, a client sends an HTTP request to a server, and the server returns a response.

### REST API Communication

```text
Shell Script
      │
HTTP Request
      │
      ▼
REST API Server
      │
HTTP Response (JSON)
      │
      ▼
Shell Script
```

Example:

A shell script requests user information from an API.

```text
GET /users/1
```

The server responds:

```json
{
  "id": 1,
  "name": "John Doe"
}
```

---

# 1.2 HTTP Methods

REST APIs use different HTTP methods based on the required operation.

| Method | Purpose |
|---------|---------|
| GET | Retrieve data |
| POST | Create new data |
| PUT | Update existing data |
| PATCH | Partially update data |
| DELETE | Delete data |

Example:

```text
GET    /users
POST   /users
PUT    /users/1
DELETE /users/1
```

---

# 1.3 What is curl?

`curl` is a command-line tool used to send HTTP requests.

Basic syntax:

```bash
curl <URL>
```

Example:

```bash
curl https://jsonplaceholder.typicode.com/posts/1
```

Output:

```json
{
  "userId": 1,
  "id": 1,
  "title": "...",
  "body": "..."
}
```

---

# 1.4 GET Request

A GET request retrieves information from the server.

Example:

```bash
#!/bin/bash

curl https://jsonplaceholder.typicode.com/users/1
```

This sends a GET request and prints the response.

---

# 1.5 POST Request

A POST request creates new data.

Example:

```bash
curl -X POST \
https://jsonplaceholder.typicode.com/posts \
-H "Content-Type: application/json" \
-d '{
"title":"Shell",
"body":"Learning REST API",
"userId":1
}'
```

Explanation:

- `-X POST` specifies the HTTP method.
- `-H` adds an HTTP header.
- `-d` sends the request body (JSON).

---

# 1.6 PUT Request

A PUT request updates an existing resource.

Example:

```bash
curl -X PUT \
https://jsonplaceholder.typicode.com/posts/1 \
-H "Content-Type: application/json" \
-d '{
"id":1,
"title":"Updated Title",
"body":"Updated Body",
"userId":1
}'
```

---

# 1.7 DELETE Request

Deletes a resource.

Example:

```bash
curl -X DELETE \
https://jsonplaceholder.typicode.com/posts/1
```

---

# 1.8 Sending Headers

Headers provide additional information about the request.

Example:

```bash
curl \
-H "Content-Type: application/json" \
-H "Authorization: Bearer TOKEN" \
https://example.com/api
```

Common headers:

| Header | Purpose |
|---------|---------|
| Content-Type | Specifies the data format |
| Authorization | Sends authentication credentials |
| Accept | Specifies the expected response format |

---

# 1.9 Sending JSON Data

Most REST APIs exchange data in JSON format.

Example:

```json
{
  "name":"Viral",
  "city":"Junagadh"
}
```

Sending JSON:

```bash
curl -X POST \
-H "Content-Type: application/json" \
-d '{"name":"Viral"}'
```

---

# 1.10 Reading API Response

The response is usually printed to the terminal.

It can also be stored in a variable.

Example:

```bash
response=$(curl -s https://jsonplaceholder.typicode.com/posts/1)

echo "$response"
```

The `-s` option runs curl in **silent mode**, hiding the progress meter.

---

# 1.11 HTTP Status Codes

Every HTTP request returns a status code.

| Code | Meaning |
|------|---------|
| 200 | OK |
| 201 | Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Internal Server Error |

Example:

```text
HTTP/1.1 200 OK
```

indicates the request was successful.

---

# 1.12 Authentication using API Tokens

Many APIs require authentication.

A token is sent using the Authorization header.

Example:

```bash
TOKEN="your_api_token"

curl \
-H "Authorization: Bearer $TOKEN" \
https://api.example.com/users
```

This allows the server to verify the client's identity.

---

# 1.13 Practical Example

Suppose we want to fetch all posts.

```bash
#!/bin/bash

echo "Fetching Posts..."

curl https://jsonplaceholder.typicode.com/posts

echo

echo "Completed."
```

Output:

```text
Fetching Posts...

[JSON Response]

Completed.
```

---

# 1.14 DevOps Use Cases

REST APIs are widely used in DevOps automation.

Examples:

- Trigger Jenkins builds.
- Create Azure DevOps pipelines.
- Deploy applications.
- Create AWS resources.
- Manage Kubernetes clusters.
- Fetch monitoring metrics.
- Send Slack notifications.
- Interact with GitHub repositories.

Example:

```bash
curl \
-X POST \
-H "Authorization: Bearer TOKEN" \
https://dev.azure.com/organization/project/_apis/pipelines/1/runs?api-version=7.1
```

A shell script can trigger an Azure DevOps pipeline using its REST API.

---

# 1.15 Extra Topics

## JSON

JSON (JavaScript Object Notation) is the most common format used for REST API communication.

Example:

```json
{
  "name": "Viral",
  "role": "Developer"
}
```

---

## HTTP Status Codes

| Code | Description |
|------|-------------|
| 200 | Success |
| 201 | Resource Created |
| 400 | Invalid Request |
| 401 | Authentication Required |
| 403 | Access Denied |
| 404 | Resource Not Found |
| 500 | Server Error |

---

## curl Command

Useful options:

| Option | Purpose |
|---------|---------|
| `-X` | Specify HTTP method |
| `-H` | Add request header |
| `-d` | Send request body |
| `-o` | Save response to a file |
| `-s` | Silent mode |
| `-I` | Fetch only response headers |

---

# 1.16 Summary

- REST APIs allow applications to communicate over HTTP.
- `curl` is the standard command-line tool used to invoke REST APIs from shell scripts.
- Common HTTP methods include GET, POST, PUT, PATCH, and DELETE.
- Headers provide metadata such as content type and authentication.
- JSON is the most common data format used by REST APIs.
- Shell scripts can automate API calls for cloud services, CI/CD pipelines, monitoring, and deployments.
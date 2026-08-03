# 1. Jenkinsfile

## 1.1 What is a Jenkinsfile?

A **Jenkinsfile** is a text file that defines an entire Jenkins Pipeline **as code**.

Instead of configuring jobs manually through the Jenkins UI, all pipeline stages, steps, and configurations are written in a file and stored in the project's Git repository.

This concept is known as **Pipeline as Code**.

Example:

```
Project/

├── src/

├── pom.xml

├── Dockerfile

└── Jenkinsfile
```

When Jenkins detects this file, it executes the pipeline automatically.

---

# 2. Why Use a Jenkinsfile?

Without a Jenkinsfile:

- Pipeline configuration exists only in Jenkins.
- Difficult to track changes.
- Hard to replicate on another Jenkins server.
- Pipeline changes are not version controlled.

With a Jenkinsfile:

- Stored in Git.
- Version controlled.
- Easy to review using Pull Requests.
- Same pipeline can be reused across environments.
- Easy backup and recovery.

---

# 3. Pipeline as Code

Instead of clicking through the Jenkins UI:

```
Configure Job

↓

Build Step

↓

Save
```

We simply write:

```groovy
pipeline {
    ...
}
```

Advantages:

- Reproducible
- Easy collaboration
- Version control
- Infrastructure as Code approach

---

# 4. Types of Jenkins Pipelines

## 4.1 Declarative Pipeline (Recommended)

Simple, structured, and easy to read.

Example:

```groovy
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
    }
}
```

Recommended for most projects.

---

## 4.2 Scripted Pipeline

Written entirely in Groovy.

Provides more flexibility but is more complex.

Example:

```groovy
node {
    stage('Build') {
        echo 'Building...'
    }
}
```

Used for advanced pipeline logic.

---

# 5. Jenkinsfile Structure

Basic structure:

```groovy
pipeline {

    agent any

    stages {

        stage('Build') {

            steps {

            }

        }

    }

}
```

Main components:

- pipeline
- agent
- stages
- stage
- steps

---

# 6. Agent

The **agent** specifies where the pipeline runs.

Example:

```groovy
agent any
```

Meaning:

Run on any available Jenkins agent.

Other examples:

```groovy
agent none
```

```groovy
agent {
    label 'linux'
}
```

---

# 7. Stages

A pipeline is divided into logical stages.

Example:

```
Build

↓

Test

↓

Deploy
```

Example:

```groovy
stage('Build')
```

Each stage represents one phase of the CI/CD process.

---

# 8. Steps

Steps are individual commands executed inside a stage.

Example:

```groovy
steps {

    echo "Hello"

}
```

or

```groovy
steps {

    sh 'mvn clean package'

}
```

---

# 9. Complete Jenkinsfile Example

```groovy
pipeline {

    agent any

    stages {

        stage('Checkout') {

            steps {
                git 'https://github.com/example/demo.git'
            }

        }

        stage('Build') {

            steps {
                sh 'mvn clean package'
            }

        }

        stage('Test') {

            steps {
                sh 'mvn test'
            }

        }

        stage('Deploy') {

            steps {
                echo 'Deploying Application...'
            }

        }

    }

}
```

Pipeline Flow:

```
Checkout

↓

Build

↓

Test

↓

Deploy
```

---

# 10. Environment Variables

Environment variables can be defined once and used throughout the pipeline.

Example:

```groovy
environment {

    APP_NAME = "SpringBoot"

}
```

Usage:

```groovy
echo "${APP_NAME}"
```

---

# 11. Post Section

The **post** block executes after the pipeline completes.

Example:

```groovy
post {

    always {

        echo "Pipeline Finished"

    }

    success {

        echo "Build Successful"

    }

    failure {

        echo "Build Failed"

    }

}
```

Common options:

- always
- success
- failure
- unstable
- aborted

---

# 12. Parameters

Parameters allow users to provide input before running a pipeline.

Example:

```groovy
parameters {

    string(name: 'BRANCH',
           defaultValue: 'main')

}
```

Users can choose the branch at build time.

---

# 13. Practical

## Objective

Create a Jenkins Pipeline using a Jenkinsfile.

### Step 1

Create a Git repository.

---

### Step 2

Add a file named:

```
Jenkinsfile
```

---

### Step 3

Paste:

```groovy
pipeline {

    agent any

    stages {

        stage('Build') {

            steps {

                echo "Hello Jenkins"

            }

        }

    }

}
```

---

### Step 4

Commit and push:

```bash
git add .

git commit -m "Added Jenkinsfile"

git push
```

---

### Step 5

Create a **Pipeline Job** in Jenkins.

Configure:

```
Pipeline

↓

Pipeline script from SCM

↓

Git

↓

Repository URL

↓

Branch
```

Save.

---

### Step 6

Click:

```
Build Now
```

Expected Output:

```
Hello Jenkins

Finished: SUCCESS
```

---

# 14. Best Practices

- Always store the Jenkinsfile in the project repository.
- Keep each stage focused on a single task.
- Use descriptive stage names.
- Avoid hardcoding credentials.
- Store secrets in Jenkins Credentials.
- Keep pipelines modular and readable.
- Use Declarative Pipelines unless advanced scripting is required.

---

# 15. Common Errors

| Error | Cause | Solution |
|--------|-------|----------|
| Jenkinsfile not found | Wrong repository path | Ensure the file is at the repository root or configure the correct script path |
| Pipeline syntax error | Invalid Groovy syntax | Validate using the Pipeline Syntax Generator |
| Command not found | Tool not installed | Configure JDK, Maven, Git, or Docker in Jenkins |
| Permission denied | Missing credentials | Configure Jenkins Credentials correctly |
| Stage failed | Build/test command failed | Review Console Output for details |

---

# 16. Interview Questions

1. What is a Jenkinsfile?
2. What is Pipeline as Code?
3. Difference between Declarative and Scripted Pipelines.
4. What is the purpose of the `agent` directive?
5. Difference between `stage` and `steps`.
6. What is the `post` section?
7. Why should a Jenkinsfile be stored in Git?
8. How do you pass parameters to a Jenkins pipeline?
9. How are environment variables defined in a Jenkinsfile?
10. What are the advantages of using Jenkins Pipelines over Freestyle jobs?

---

# 17. Summary

- A **Jenkinsfile** defines a complete CI/CD pipeline as code.
- It is stored in the project's Git repository, making pipelines version-controlled and reusable.
- The recommended approach is the **Declarative Pipeline**, which uses directives like `pipeline`, `agent`, `stages`, `stage`, `steps`, `environment`, and `post`.
- Jenkins reads the Jenkinsfile, executes each stage in order, and displays the results in the Pipeline view and Console Output.
- Using Jenkinsfiles improves collaboration, consistency, and maintainability compared to configuring jobs manually through the Jenkins UI.
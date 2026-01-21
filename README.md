

````markdown
# Terraform AWS Infrastructure & CI/CD Project

## Overview

This project demonstrates how to provision AWS infrastructure using **Terraform modules** and deploy an application using **CI/CD pipelines**. The architecture supports **multiple environments** (dev, prod) and demonstrates a full DevOps workflow: infrastructure provisioning, application build, artifact storage, deployment, and state management.

The key goals are:

* Terraform module reuse
* Multi-environment infrastructure provisioning
* CI/CD pipeline design
* Application deployment on EC2 using Docker
* Proper state management and infrastructure safety

---

## Complete Architecture & Flow

### 1. Terraform Remote State (S3 + DynamoDB)

Terraform uses **S3 buckets** to store state files and **DynamoDB tables** for state locking to prevent concurrent writes.

**S3 bucket template (`terraform.tf`):**

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "project/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
````

* `bucket` → Stores Terraform state file
* `key` → Path inside the bucket, separated per environment (`dev`, `prod`)
* `dynamodb_table` → Locking table to prevent concurrent apply
* `encrypt` → State file is encrypted at rest

**DynamoDB Table Template (`dynamodb.tf`):**

```hcl
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
```

---

### 2. Infrastructure Setup Pipeline (Terraform CI)

**Purpose:** Automatically provision infrastructure using Terraform.

**Pipeline YAML (`terraform-ci.yml`)**

**Stages & Flow:**

1. **Terraform Init** – Initializes backend (S3 + DynamoDB)
2. **Terraform Validate** – Checks syntax and config correctness
3. **Terraform Plan** – Generates execution plan
5. **Terraform Apply** – Creates AWS resources

**Resources Created by Pipeline:**

| Resource Type   | Purpose                                          |
| --------------- | ------------------------------------------------ |
| S3 Bucket       | Stores application artifacts and Terraform state |
| EC2 Instances   | Runs the application container                   |
| DynamoDB Table  | Manages Terraform state locks                    |
| Security Groups | Allows SSH / application traffic                 |

---

### 3. Application CI Pipeline (`deploy-app.yml`)

**Purpose:** Build the application, create a Docker image, and push artifacts.

**Pipeline Steps:**

1. **Build Application** – Compile Java app from `app/simple-java-docker/src`
2. **Build Docker Image** – Create Docker image from `Dockerfile`
3. **Push Image to S3 / ECR** – Store artifact in S3 for EC2 to pull

**Artifact Flow:**

```
Code Commit → Build → Docker Image → S3 Bucket 
```

---

### 4. Application CD Pipeline

**Purpose:** Deploy the application on EC2 instances provisioned by Terraform.

**Steps:**

1. **SSH into EC2** – Connect using SSH key (`terra-key-ec2`)
2. **Pull Latest Docker Image** – Fetch image from S3 or ECR
3. **Stop Existing Container**
4. **Run New Container** – Deploy updated application
5. **Logging & Monitoring** – Optional CloudWatch or Prometheus integration

**Deployment Flow:**

```
Artifact in S3 → Pull on EC2 → Stop old container → Run new container
```

---

### 5. State Management

* Terraform stores all resources in the **S3 backend**.
* Every apply updates the state file:

  * Which EC2 instances exist
  * Which S3 buckets exist
  * Which Docker deployments are associated
* DynamoDB ensures **single apply at a time**, avoiding conflicts.

---

### 6. Key Takeaways

* Terraform manages infrastructure **declaratively**
* CI/CD pipelines handle application **build and deployment**
* S3 + DynamoDB ensures **safe state management**
* EC2 runs **Docker containers** with up-to-date artifacts
* Multi-environment support allows safe **dev/prod deployments**
```

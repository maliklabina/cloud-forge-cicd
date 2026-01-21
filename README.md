# Terraform AWS Infrastructure & CI/CD Project

## Overview

This project demonstrates an end-to-end **DevOps workflow** using **Terraform**, **AWS**, **Docker**, and **CI/CD pipelines**. It focuses on provisioning cloud infrastructure using reusable Terraform modules and deploying a containerized application on EC2 through automated pipelines.

The architecture supports **multiple environments** (`dev`, `prod`) and follows **industry best practices** for infrastructure automation, application delivery, and Terraform state management.

---

## Project Objectives

- Provision AWS infrastructure using Terraform modules
- Support multiple environments (dev, prod)
- Implement CI/CD pipelines for infrastructure and application
- Deploy a Dockerized application on EC2
- Manage Terraform state securely using S3 and DynamoDB

---

## Technology Stack

- **Infrastructure as Code:** Terraform
- **Cloud Provider:** AWS
- **Compute:** EC2
- **State Management:** S3 + DynamoDB
- **Containerization:** Docker
- **CI/CD:** GitHub Actions
- **Application:** Java 

---

## Terraform Remote State Management

Terraform uses a **remote backend** to store state files securely and prevent concurrent state updates.

### S3 Backend Configuration

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

### Key Benefits

* Centralized state storage
* Environment-specific state isolation
* State file encryption at rest
* Safe concurrent execution using DynamoDB locking

### DynamoDB State Lock Table

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

## Infrastructure CI Pipeline (Terraform)

### Purpose

Automates the provisioning and management of AWS infrastructure using Terraform.

### Pipeline Flow

1. Terraform Init – Initializes backend and providers
2. Terraform Validate – Validates Terraform configuration
3. Terraform Plan – Generates execution plan
4. Terraform Apply – Provisions AWS resources

### AWS Resources Provisioned

| Resource Type  | Purpose                                   |
| -------------- | ----------------------------------------- |
| S3 Bucket      | Terraform state and application artifacts |
| EC2 Instance   | Application runtime                       |
| DynamoDB Table | Terraform state locking                   |
| Security Group | SSH and application traffic control       |

---

## Application CI Pipeline

### Purpose

Builds the application and produces deployable artifacts.

### Steps

1. Build Java application
2. Build Docker image using Dockerfile
3. Push Docker image to S3 

### Artifact Flow

```
Source Code → Build → Docker Image → Artifact Storage
```

---

## Application CD Pipeline

### Purpose

Deploys the application to EC2 instances provisioned by Terraform.

### Deployment Steps

1. Connect to EC2 using SSH
2. Pull latest Docker image from artifact storage
3. Stop existing running container
4. Run new Docker container
5. Verify application status

---

## Terraform State Management

* Terraform tracks all infrastructure resources in state files
* State is stored securely in S3
* DynamoDB ensures only one apply operation runs at a time
* Prevents accidental resource drift and conflicts

---

## Environment Support

| Environment | Description             |
| ----------- | ----------------------- |
| dev         | Development and testing |
| prod        | Production deployment   |

Each environment maintains its **own isolated Terraform state**.

---

## Key Highlights

* Reusable and modular Terraform code
* Automated infrastructure provisioning
* Secure Terraform state handling
* Docker-based application deployment
* CI/CD pipelines aligned with industry standards
* Clear separation of infrastructure and application workflows

---

## Future Enhancements

* Add monitoring using CloudWatch or Prometheus
* Implement centralized logging
* Add automated testing in CI pipeline
* Introduce blue-green or rolling deployments



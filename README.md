# Terraform AWS Infrastructure & CI/CD Project

## Overview

This project demonstrates how to provision AWS infrastructure using **Terraform modules** and deploy an application using **simple CI/CD pipelines**. The setup supports **multiple environments (dev, stg, prod)** with different configurations, while keeping the architecture intentionally simple and beginner-friendly.

The goal of this project is to understand:

* Terraform module reuse
* Environment-based infrastructure provisioning
* Basic CI/CD pipeline design
* Application deployment on EC2

---

## Architecture Summary

**Cloud Provider:** AWS
**Infrastructure Tool:** Terraform
**Compute:** EC2
**Storage:** S3
**State Locking / DB:** DynamoDB
**Deployment Model:** Docker on EC2
**Environments:** dev, stg, prod

---

## Repository Structure

```
terraform-modules-app/
│
├── infra-app/                 # Reusable Terraform module
│   ├── dynamodb.tf            # DynamoDB table
│   ├── ec2.tf                 # EC2 instances
│   ├── s3.tf                  # S3 bucket
│   ├── terra-key-ec2.pub      # SSH public key
│   ├── variables.tf           # Input variables
│   ├── main.tf                # Module wiring
│   ├── providers.tf           # AWS provider config
│   └── terraform.tf           # Backend & required providers
│
├── main.tf                    # Root module (dev / stg / prod)
└── README.md
```

---

## Environment Configuration

Each environment is created by calling the same Terraform module with different inputs.

| Environment | Instance Type | Instance Count |
| ----------- | ------------- | -------------- |
| dev         | t2.micro      | 1              |
| stg         | t2.small      | 1              |
| prod        | t2.medium     | 2              |

All environments are managed from a single Terraform root configuration.

---

## Terraform Deployment Steps (Manual)

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Validate Configuration

```bash
terraform validate
```

### 3. Review Execution Plan

```bash
terraform plan
```

### 4. Apply Infrastructure

```bash
terraform apply
```

This creates infrastructure for **dev, stg, and prod** together.

---

## Destroy Only Staging Environment

To delete only the staging resources:

```bash
terraform destroy -target=module.stg-infra
```

Dev and Prod environments remain untouched.

---

## CI/CD Pipeline Design

### Infrastructure Pipeline

**Purpose:** Provision AWS infrastructure using Terraform

**Stages:**

1. Terraform Init
2. Terraform Validate
3. Terraform Plan
4. Terraform Apply (with manual approval)

**Pipeline Flow:**

```
Code Commit → Terraform Init → Plan → Manual Approval → Apply
```

---

### Application CI Pipeline

**Purpose:** Build and publish application artifacts

**Steps:**

* Build application
* Build Docker image
* Push image to container registry (ECR)

---

### Application CD Pipeline

**Purpose:** Deploy application to EC2

**Steps:**

* SSH into EC2
* Pull latest Docker image
* Stop existing container
* Start new container

**Deployment Flow:**

```
CI Build → Deploy to Dev → Approval → Deploy to Prod
```

---

## Security & Best Practices

* Terraform state stored remotely
* DynamoDB used for state locking
* No secrets hardcoded in code
* Environment separation via configuration
* Manual approval before production deployment

---

## Learning Outcomes

By completing this project, you will understand:

* Terraform module design
* Multi-environment infrastructure provisioning
* Basic CI/CD pipeline structure
* Safe deployment practices
* Real-world DevOps workflows

---

## Future Improvements

* Separate Terraform state per environment
* Introduce Terraform workspaces or env folders
* Add monitoring and logging (CloudWatch / Prometheus)
* Automate EC2 configuration using user-data or Ansible
* Migrate deployment to Kubernetes

---

## Project Summary (Interview Ready)

> This project uses Terraform modules to provision AWS infrastructure for multiple environments. CI/CD pipelines automate infrastructure deployment and application delivery. The setup demonstrates environment-based configuration, infrastructure automation, and basic production safety practices.
# Testing GitHub Actions Workflows


## comment

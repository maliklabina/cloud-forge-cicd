# GitHub Actions for Terraform

This directory contains GitHub Actions workflows that automate Terraform infrastructure deployment.

## Workflows

### 1. **Terraform Plan** (`terraform-plan.yml`)
- **Triggers:** On Pull Requests
- **What it does:**
  - Runs `terraform init`
  - Checks code formatting with `terraform fmt`
  - Validates configuration with `terraform validate`
  - Creates a plan and comments it on the PR
- **Requirements:** PR must target main branch with changes to `.tf` files

### 2. **Terraform Apply** (`terraform-apply.yml`)
- **Triggers:** On push to main branch
- **What it does:**
  - Runs `terraform init`
  - Validates and plans the infrastructure
  - Applies the plan automatically
  - Posts outputs as a comment
- **Requirements:** Must pass all status checks; AWS credentials configured

### 3. **Terraform Destroy** (`terraform-destroy.yml`)
- **Triggers:** Manual workflow dispatch (Actions tab)
- **What it does:**
  - Allows selective destruction: dev only, prod only, or all
  - Runs `terraform destroy` for selected targets
- **Options:**
  - `dev`: Destroys only dev environment
  - `prod`: Destroys only prod environment
  - `all`: Destroys everything

## Setup Instructions

### 1. Add AWS Credentials to Secrets
Go to **Settings → Secrets and variables → Actions** and add:

```
AWS_ACCESS_KEY_ID       = your_access_key
AWS_SECRET_ACCESS_KEY   = your_secret_key
```

### 2. Add Environment Protection (Optional)
Go to **Settings → Environments** and create a `production` environment with required reviewers for safety.

### 3. Set SSH Key
Add your public key content to the repo or GitHub Secrets:
```
SSH_PUBLIC_KEY = (contents of terra-key-ec2.pub)
```

## Usage

### Creating a PR (Plan)
```bash
git checkout -b feature/update-infra
# Make changes to .tf files
git commit -m "Update infrastructure"
git push origin feature/update-infra
```
Go to GitHub and create a PR. The Plan workflow will automatically run and comment the plan.

### Merging to Main (Apply)
Once approved and merged to main, the Apply workflow runs automatically and deploys infrastructure.

### Manual Destroy
1. Go to **Actions** tab
2. Select **Terraform Destroy**
3. Click **Run workflow**
4. Select environment: dev, prod, or all
5. Confirm

## Workflow File Paths
- `.github/workflows/terraform-plan.yml`
- `.github/workflows/terraform-apply.yml`
- `.github/workflows/terraform-destroy.yml`

## Environment Variables
- **Region:** `us-east-2` (hardcoded, modify in workflows if needed)
- **Terraform Version:** `1.14.3` (matches your local setup)

## Safety Features
- ✅ Format checking before deploy
- ✅ Validation before apply
- ✅ Plan review before apply (visible in PR)
- ✅ Production environment requires approval for sensitive operations
- ✅ Manual destroy to prevent accidental deletions
- ✅ Selective destroy (dev/prod/all options)

## Troubleshooting

**Issue:** "AWS credentials not found"
- Solution: Add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` to repository secrets

**Issue:** "Terraform plan failed"
- Solution: Check the workflow run logs in Actions tab for details

**Issue:** "Permission denied" on destroy
- Solution: Ensure you have write access to the repository and the branch is protected appropriately

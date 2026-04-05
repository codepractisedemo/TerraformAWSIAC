# Terraform AWS EC2 + VPC + Subnet + GitHub Actions

This project creates the following in **AWS eu-central-1**:
- 1 VPC
- 1 public subnet
- 1 Internet Gateway
- 1 public route table
- 1 security group
- 1 EC2 instance running **Amazon Linux 2023** with **Nginx**
- 1 GitHub Actions workflow for `plan` and `apply`

## Project structure

```text
.
├── .github/workflows/terraform.yml
├── bootstrap-oidc/
├── main.tf
├── outputs.tf
├── providers.tf
├── terraform.tfvars.example
├── user_data.sh
├── variables.tf
└── versions.tf
```

## Prerequisites

- AWS account
- GitHub repository
- Terraform >= 1.6
- An IAM role for GitHub Actions OIDC

## Deploy locally

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply -auto-approve
```

## GitHub Actions setup

### 1. Create repository secret
Create this GitHub secret in your repository:
- `AWS_ROLE_TO_ASSUME` = IAM role ARN that GitHub Actions should assume

### 2. Push code to GitHub

```bash
git init
git add .
git commit -m "Initial Terraform for AWS EC2 and VPC"
git branch -M main
git remote add origin https://github.com/YOUR_ORG/YOUR_REPO.git
git push -u origin main
```

### 3. Workflow behavior
- On **pull request to main**: runs `fmt`, `init`, `validate`, and `plan`
- On **push to main**: runs `fmt`, `init`, `validate`, and `apply`
- On **manual trigger**: runs deploy from GitHub Actions UI

## OIDC bootstrap (optional but recommended)

The `bootstrap-oidc/` folder helps you create an IAM OIDC provider and deploy role for GitHub Actions.

Example:

```bash
cd bootstrap-oidc
terraform init
terraform apply \
  -var="github_org=YOUR_GITHUB_USERNAME_OR_ORG" \
  -var="github_repo=YOUR_REPO_NAME"
```

After apply, copy the output role ARN into your GitHub repository secret:
- `AWS_ROLE_TO_ASSUME`

## Notes

- The EC2 instance is created in a **public subnet**.
- HTTP (80) is open to the internet.
- SSH (22) is open based on `allowed_ssh_cidr`. Restrict this before production use.
- `key_name` is optional. If you do not need SSH, leave it as `null`.



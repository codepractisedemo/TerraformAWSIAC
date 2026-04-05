variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "github_org" {
  description = "GitHub organization or username"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "role_name" {
  description = "IAM role name for GitHub Actions"
  type        = string
  default     = "gha-terraform-eucentral-role"
}

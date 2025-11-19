# Basic info
variable "clinic_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "service_plan_id" {
  type = string
}

# Docker image placeholder (pipeline overrides)
variable "image_name" {
  type    = string
  default = "medusa-backend"
}

variable "image_tag" {
  type    = string
  default = "latest"
}

# Medusa DB
variable "database_url" {
  type        = string
  sensitive   = true
  description = "Full postgres URL"
}

# Medusa Secrets
variable "jwt_secret" {
  type      = string
  sensitive = true
}

variable "cookie_secret" {
  type      = string
  sensitive = true
}

# Optional
variable "redis_url" {
  type      = string
  default   = ""
  sensitive = true
}

variable "public_backend_url" {
  type    = string
  default = ""
}

# Metadata
variable "github_token" {
  type      = string
  sensitive = true
  default   = ""
}

variable "plan_sku" { type = string }
variable "repo_url" { type = string }
variable "repo_branch" { type = string }

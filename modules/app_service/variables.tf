variable "service_plan_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "clinic_name" {
  type = string
}

# Docker image
variable "image_name" {
  type = string
}

variable "image_tag" {
  type = string
}

# Database
variable "db_host" {
  type = string
}

variable "db_port" {
  type = number
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "database_url" {
  type = string
}

# Secrets
variable "jwt_secret" {
  type = string
}

variable "cookie_secret" {
  type = string
}

# Optional branding
variable "linked_storefront_url" {
  type      = string
  default   = null
}

variable "backend_url" {
  type      = string
  default   = null
}

variable "brand_primary_color" {
  type      = string
  default   = null
}

variable "brand_secondary_color" {
  type      = string
  default   = null
}

variable "brand_logo_url" {
  type      = string
  default   = null
}

variable "brand_favicon_url" {
  type      = string
  default   = null
}

# GitHub token (pipeline)
variable "github_token" {
  type = string
}

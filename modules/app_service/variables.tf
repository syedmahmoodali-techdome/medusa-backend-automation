# Basic info
variable "clinic_name" {
  type        = string
  description = "Clinic name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "service_plan_id" {
  type        = string
  description = "App Service Plan ID"
}

# Container image placeholders (pipeline will set actual image)
variable "image_name" {
  type        = string
  description = "Docker image name (placeholder)"
  default     = "strapi-cms"
}

variable "image_tag" {
  type        = string
  description = "Docker image tag (placeholder)"
  default     = "latest"
}

# Database config
variable "db_host" {
  type        = string
  description = "Database host / FQDN"
}

variable "db_port" {
  type        = number
  description = "Database port"
  default     = 5432
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_user" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}

variable "database_url" {
  type = string
}

# Strapi admin
variable "strapi_admin_email" {
  type        = string
}

variable "strapi_admin_password" {
  type        = string
  sensitive   = true
}

# Secrets (passed from root randoms)
variable "app_keys" {
  type        = string
  sensitive   = true
}

variable "api_token_salt" {
  type        = string
  sensitive   = true
}

variable "admin_jwt_secret" {
  type        = string
  sensitive   = true
}

variable "transfer_token_salt" {
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "Strapi JWT secret for user authentication"
  type        = string
  sensitive   = true
}


# Optional fields
variable "linked_storefront_url" {
  type    = string
  default = ""
}

variable "backend_url" {
  type    = string
  default = ""
}

variable "github_token" {
  type      = string
  sensitive = true
  default   = ""
}

# Branding
variable "brand_primary_color" {
  type    = string
  default = ""
}
variable "brand_secondary_color" {
  type    = string
  default = ""
}
variable "brand_logo_url" {
  type    = string
  default = ""
}
variable "brand_favicon_url" {
  type    = string
  default = ""
}

# Metadata
variable "plan_sku" { type = string }
variable "repo_url" { type = string }
variable "repo_branch" { type = string }

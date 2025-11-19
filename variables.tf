variable "clinic_name" {
  description = "Clinic name (used for naming resources)"
  type        = string
}

#variable "database_url" {
#  type = string
#}

variable "clinic_region" {
  description = "Azure region (example: centralus)"
  type        = string
}

variable "clinic_environment" {
  description = "Environment (staging, prod, etc.)"
  type        = string
}

variable "azure_resource_group_prefix" {
  description = "Prefix used for resource group name"
  type        = string
}

variable "azure_app_service_plan_sku" {
  description = "App Service Plan SKU (e.g., B1)"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database administrator username"
  type        = string
}

variable "db_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "strapi_repo" {
  description = "Strapi repo URL"
  type        = string
}

variable "strapi_branch" {
  description = "Strapi repo branch"
  type        = string
}

variable "strapi_repo_subdir" {
  description = "Subdirectory in repo for the Strapi project"
  type        = string
  default     = ""
}

variable "strapi_admin_email" {
  description = "Initial Strapi admin email"
  type        = string
}

variable "strapi_admin_password" {
  description = "Initial Strapi admin password (will be marked sensitive)"
  type        = string
  sensitive   = true
}

variable "linked_storefront_url" {
  description = "Optional linked storefront URL"
  type        = string
  default     = ""
}

variable "backend_url" {
  description = "Optional backend URL"
  type        = string
  default     = ""
}

variable "brand_primary_color" {
  description = "Brand primary color"
  type        = string
  default     = ""
}

variable "brand_secondary_color" {
  description = "Brand secondary color"
  type        = string
  default     = ""
}

variable "brand_logo_url" {
  description = "Brand logo URL"
  type        = string
  default     = ""
}

variable "brand_favicon_url" {
  description = "Brand favicon URL"
  type        = string
  default     = ""
}

variable "strapi_admin_firstname" {
  type = string
  default = "Admin"
}

variable "strapi_admin_lastname" {
  type = string
  default = "User"
}

variable "github_token" {
  description = "GitHub token (passed to pipeline via -var if needed)"
  type        = string
  default     = ""
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 1.5.0"
}
 
provider "azurerm" {
  features {}
}

# ----------------------
# Resource Group Module
# ----------------------
module "resource_group" {
  source      = "./modules/resource_group"
  name_prefix = var.azure_resource_group_prefix
  environment = var.clinic_environment
  location    = var.clinic_region
}

# ----------------------
# Database Module
# ----------------------
module "database" {
  source              = "./modules/database"
  resource_group_name = module.resource_group.name
  location            = var.clinic_region
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
}

# ----------------------
# App Service Plan
# ----------------------
resource "azurerm_service_plan" "strapi" {
  name                = "${lower(var.clinic_name)}-plan"
  location            = var.clinic_region
  resource_group_name = module.resource_group.name
  sku_name            = var.azure_app_service_plan_sku
  os_type             = "Linux"
}

# ----------------------
# App Service module
# ----------------------
module "app_service" {
  source              = "./modules/app_service"
  service_plan_id     = azurerm_service_plan.strapi.id
  resource_group_name = module.resource_group.name
  location            = var.clinic_region
  clinic_name         = var.clinic_name

  # docker image placeholders (pipeline will set actual image)
  image_name = "strapi-cms"
  image_tag  = "latest"

  # DB config (from database module)
  db_host     = module.database.db_fqdn
  db_port     = module.database.db_port
  db_name     = module.database.db_name
  db_user     = module.database.db_username
  db_password = module.database.db_password

  # Strapi admin
  strapi_admin_email    = var.strapi_admin_email
  strapi_admin_password = var.strapi_admin_password

  # Strapi secrets generated here (you already had random resources)
  app_keys            = random_password.app_keys.result
  api_token_salt      = random_password.api_token_salt.result
  admin_jwt_secret    = random_password.admin_jwt_secret.result
  transfer_token_salt = random_password.transfer_token_salt.result
  jwt_secret = random_password.jwt_secret.result


  # optional integrations & branding
  linked_storefront_url = var.linked_storefront_url
  backend_url           = var.backend_url

  brand_primary_color   = var.brand_primary_color
  brand_secondary_color = var.brand_secondary_color
  brand_logo_url        = var.brand_logo_url
  brand_favicon_url     = var.brand_favicon_url

  # metadata for reference
  plan_sku    = var.azure_app_service_plan_sku
  repo_url    = var.strapi_repo
  repo_branch = var.strapi_branch
  #repo_subdir = var.strapi_repo_subdir

  github_token = var.github_token
}

# ----------------------
# Random passwords / salts
# ----------------------
resource "random_password" "app_keys" {
  length  = 32
  special = false
}

resource "random_password" "api_token_salt" {
  length  = 32
  special = false
}

resource "random_password" "admin_jwt_secret" {
  length  = 32
  special = false
}

resource "random_password" "transfer_token_salt" {
  length  = 32
  special = false
}

resource "random_password" "jwt_secret" {
  length  = 32
  special = false
}

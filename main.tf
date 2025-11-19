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
# Resource Group
# ----------------------
module "resource_group" {
  source      = "./modules/resource_group"
  name_prefix = var.azure_resource_group_prefix
  environment = var.clinic_environment
  location    = var.clinic_region
}

# ----------------------
# Database Module (Postgres)
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
resource "azurerm_service_plan" "app" {
  name                = "${lower(var.clinic_name)}-plan"
  location            = var.clinic_region
  resource_group_name = module.resource_group.name
  sku_name            = var.azure_app_service_plan_sku
  os_type             = "Linux"
}

# ----------------------
# Medusa App Service
# ----------------------
module "app_service" {
  source              = "./modules/app_service"
  service_plan_id     = azurerm_service_plan.app.id
  resource_group_name = module.resource_group.name
  location            = var.clinic_region
  clinic_name         = var.clinic_name

  # Docker image (pipeline replaces these)
  image_name = var.image_name
  image_tag  = var.image_tag

  # DB config (from module.database)
  db_host     = module.database.db_fqdn
  db_port     = module.database.db_port
  db_name     = module.database.db_name
  db_user     = module.database.db_username
  db_password = module.database.db_password

  # Medusa specific
  database_url  = module.database.connection_string
  cookie_secret = var.cookie_secret

  jwt_secret = random_password.jwt_secret.result

  # Optional branding / URLs
  linked_storefront_url = var.linked_storefront_url
  backend_url           = var.backend_url

  brand_primary_color   = var.brand_primary_color
  brand_secondary_color = var.brand_secondary_color
  brand_logo_url        = var.brand_logo_url
  brand_favicon_url     = var.brand_favicon_url

  github_token = var.github_token
}

# ----------------------
# Random secrets
# ----------------------
resource "random_password" "jwt_secret" {
  length  = 32
  special = false
}

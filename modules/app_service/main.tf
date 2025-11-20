provider "azurerm" {
  features {}
}

# Container Registry (ACR)
resource "azurerm_container_registry" "acr" {
  name                = "${replace(lower(var.clinic_name), "-", "")}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Linux Web App
resource "azurerm_linux_web_app" "app_service" {
  name                = "${lower(var.clinic_name)}-app"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    always_on = true
  }

  app_settings = {
    WEBSITES_PORT                        = "9000"
    PORT = "9000"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE  = "false"
    COOKIE_SECRET = var.cookie_secret
    #DATABASE_URL  = var.database_url

    # DB
    DATABASE_CLIENT      = "postgres"
    DATABASE_HOST        = var.db_host
    DATABASE_PORT        = tostring(var.db_port)
    DATABASE_NAME        = var.db_name
    DATABASE_USERNAME    = var.db_user
    DATABASE_PASSWORD    = var.db_password

    # i added these two to fix the error: Cannot send secure cookie over unencrypted connection
    TRUST_PROXY                 = "true"
    ADMIN_FORCE_SECURE_COOKIES  = "false"
    NODE_ENV                        = "production"

    # Strapi admin
    STRAPI_ADMIN_EMAIL    = var.strapi_admin_email
    STRAPI_ADMIN_PASSWORD = var.strapi_admin_password
    

    # Strapi secrets
    APP_KEYS             = var.app_keys
    API_TOKEN_SALT       = var.api_token_salt
    ADMIN_JWT_SECRET     = var.admin_jwt_secret
    TRANSFER_TOKEN_SALT  = var.transfer_token_salt

    # Optional integrations & branding
    LINKED_STOREFRONT_URL = var.linked_storefront_url
    BACKEND_URL           = var.backend_url

    BRAND_PRIMARY_COLOR   = var.brand_primary_color
    BRAND_SECONDARY_COLOR = var.brand_secondary_color
    BRAND_LOGO_URL        = var.brand_logo_url
    BRAND_FAVICON_URL     = var.brand_favicon_url
    JWT_SECRET = var.jwt_secret
  }
}

# Outputs
output "app_service_name" {
  value = azurerm_linux_web_app.app_service.name
}

output "cms_url" {
  value = azurerm_linux_web_app.app_service.default_hostname
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

# Provide ACR admin credentials for pipeline convenience
output "acr_admin_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}

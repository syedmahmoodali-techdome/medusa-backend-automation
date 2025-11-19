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

    # pipeline will set final image
    application_stack {
      docker_image_name   = "${var.image_name}:${var.image_tag}"
      docker_registry_url = "https://${azurerm_container_registry.acr.login_server}"
    }
  }

  app_settings = {
    WEBSITES_PORT                       = "9000"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    NODE_ENV                            = "production"
    TRUST_PROXY                         = "true"

    # Medusa database (single URL string)
    DATABASE_URL = var.database_url

    # Medusa secrets
    JWT_SECRET    = var.jwt_secret
    COOKIE_SECRET = var.cookie_secret

    # Optional features
    REDIS_URL = var.redis_url
    PUBLIC_BACKEND_URL = var.public_backend_url
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

output "acr_admin_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}

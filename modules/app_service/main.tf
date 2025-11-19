resource "azurerm_container_registry" "acr" {
  name                = "${replace(lower(var.clinic_name), "-", "")}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "${lower(var.clinic_name)}-app"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    always_on = true

    application_stack {
      docker_image_name   = "${var.image_name}:${var.image_tag}"
      docker_registry_url = "https://${azurerm_container_registry.acr.login_server}"
    }
  }

  app_settings = {
    WEBSITES_PORT = "9000"

    # Medusa + DB
    DATABASE_URL = var.database_url
    JWT_SECRET   = var.jwt_secret
    COOKIE_SECRET = var.cookie_secret
    NODE_ENV = "production"

    # Optional branding
    LINKED_STOREFRONT_URL = var.linked_storefront_url
    BACKEND_URL           = var.backend_url

    BRAND_PRIMARY_COLOR   = var.brand_primary_color
    BRAND_SECONDARY_COLOR = var.brand_secondary_color
    BRAND_LOGO_URL        = var.brand_logo_url
    BRAND_FAVICON_URL     = var.brand_favicon_url

    # ACR auth
    DOCKER_REGISTRY_SERVER_URL      = "https://${azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = azurerm_container_registry.acr.admin_password
  }
}

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

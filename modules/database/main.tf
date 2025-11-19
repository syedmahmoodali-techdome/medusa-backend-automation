provider "azurerm" {
  # inherits provider config
  features {}
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                = "${var.db_name}-pg"
  resource_group_name = var.resource_group_name
  location            = var.location
  administrator_login = var.db_username
  administrator_password = var.db_password

  sku_name   = "B_Standard_B1ms"
  storage_mb = 32768
  version    = "13"

  # allow public access so App Service (without VNet) can reach it
  public_network_access_enabled = true

  # recommended defaults
  backup_retention_days = 7
  auto_grow_enabled     = true
}

# Allow Azure services to connect (start/end 0.0.0.0)
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure" {
  name      = "allow-azure-services"
  server_id = azurerm_postgresql_flexible_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.this.id
}

output "db_fqdn" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}

output "db_port" {
  value = 5432
}

output "connection_string" {
  value     = "postgres://${var.db_username}:${var.db_password}@${azurerm_postgresql_flexible_server.this.fqdn}:5432/${var.db_name}"
  sensitive = true
}

output "db_name" {
  value = var.db_name
}

output "db_username" {
  value = var.db_username
}

output "db_password" {
  value     = var.db_password
  sensitive = true
}

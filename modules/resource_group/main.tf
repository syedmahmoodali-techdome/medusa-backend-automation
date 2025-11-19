resource "azurerm_resource_group" "this" {
  name     = "${var.name_prefix}-${var.environment}-strapi-cms-rg"
  location = var.location
}

output "name" {
  value = azurerm_resource_group.this.name
}

output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

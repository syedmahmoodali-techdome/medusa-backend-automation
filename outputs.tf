output "cms_url" {
  description = "URL/hostname of the deployed Strapi CMS (default hostname)"
  value       = module.app_service.cms_url
}

output "cms_admin_email" {
  description = "configured Strapi admin email"
  value       = var.strapi_admin_email
}

output "cms_admin_password" {
  description = "initial Strapi admin password"
  value       = var.strapi_admin_password
  sensitive   = true
}

output "linked_storefront_url" {
  description = "linked storefront URL"
  value       = var.linked_storefront_url
}

output "resource_group" {
  description = "resource group name"
  value       = module.resource_group.name
}

output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "environment" {
  description = "Environment"
  value       = var.clinic_environment
}

output "app_service_name" {
  value = module.app_service.app_service_name
}

#output "acr_name" {
#  value = module.app_service.acr_name
#}

#output "acr_login_server" {
#  value = module.app_service.acr_login_server
#}

#output "acr_admin_username" {
#  description = "ACR admin username (sensitive)"
#  value       = module.app_service.acr_admin_username
#  sensitive   = true
#}

#output "acr_admin_password" {
#  description = "ACR admin password (sensitive)"
#  value       = module.app_service.acr_admin_password
#  sensitive   = true
#}

output "db_host" {
  description = "PostgreSQL FQDN"
  value       = module.database.db_fqdn
}

output "db_port" {
  description = "PostgreSQL port"
  value       = module.database.db_port
}

output "db_connection_string" {
  description = "Postgres connection string"
  value       = module.database.connection_string
  sensitive   = true
}

output "db_name" {
  value = module.database.db_name
}

output "db_user" {
  value = module.database.db_username
}

output "db_password" {
  value     = module.database.db_password
  sensitive = true
}

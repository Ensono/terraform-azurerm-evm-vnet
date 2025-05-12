output "resource_group_name" {
  description = "The Resource Group name."
  value       = azurerm_resource_group.this.name
  sensitive   = false
}

output "resource_name" {
  description = "The resource name."
  value       = module.example.vnet_name
  sensitive   = false
}

output "resource_id" {
  description = "The resource id."
  value       = module.example.vnet_resource_id
  sensitive   = false
}

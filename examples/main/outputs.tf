output "resource_group_name_example" {
  description = "The Resource Group name for the module example"
  value       = azurerm_resource_group.modules["example"].name
  sensitive   = false
}

output "name" {
  description = "The resource name of the virtual network."
  value       = module.example.vnet_name
}

output "resource_id" {
  description = "The resource ID of the virtual network."
  value       = module.example.vnet_resource_id
}

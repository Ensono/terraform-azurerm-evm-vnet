output "resource_group_name_example" {
  description = "The Resource Group name for the module example"
  value       = azurerm_resource_group.modules["example"].name
  sensitive   = false
}

output "name" {
  description = "The resource name of the virtual network."
  value       = module.example.name
}

output "resource_guid" {
  description = "The ID of the virtual network."
  value       = module.example.resource_guid
}

output "resource_id" {
  description = "The resource ID of the virtual network."
  value       = module.example.resource_id
}

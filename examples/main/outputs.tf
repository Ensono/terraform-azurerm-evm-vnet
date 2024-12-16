output "resource_group_name_example" {
  description = "The Resource Group name for the module example"
  value       = azurerm_resource_group.modules["example"].name
  sensitive   = false
}

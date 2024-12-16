output "resource_group_name_example" {
  description = "The Resource Group name for the module example"
  value       = azurerm_resource_group.modules["example"].name
  sensitive   = false
}


output "azure_location_zones" {
  description = "The Azure target location available zones"
  value       = data.azurerm_location.this.zone_mappings[*].logical_zone
  sensitive   = false
}

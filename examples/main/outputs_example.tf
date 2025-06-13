output "resource_group_name" {
  description = "The Resource Group name."
  value       = azurerm_resource_group.this.name
  sensitive   = false
}

output "vnet_name" {
  description = "The resource name."
  value       = module.example.vnet_name
  sensitive   = false
}

output "vnet_resource_id" {
  description = "The resource id."
  value       = module.example.vnet_resource_id
  sensitive   = false
}


output "subnets" {
  description = "Detailed information about each subnet."
  value       = module.example.subnets
}

output "nsg_ids" {
  description = "The IDs of the network security groups"
  value       = module.example.nsg_ids
}

output "route_table_ids" {
  description = "The IDs of the route tables"
  value       = module.example.route_table_ids
}

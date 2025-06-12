output "vnet_resource_id" {
  description = "The resource ID of the virtual network."
  value       = module.avm_res_network_virtualnetwork.resource_id
}

output "resource_group_name" {
  description = "The name of the resource group where the virtual network is created."
  value       = module.avm_res_network_virtualnetwork.resource_group_name
}

output "vnet_name" {
  description = "The resource name of the virtual network."
  value       = module.avm_res_network_virtualnetwork.name
}

output "subnets" {
  description = "Information about the subnets created in the module."
  value = {
    for subnet in module.avm_res_network_virtualnetwork.subnets : subnet.name => {
      resource_id = subnet.resource_id
      name        = subnet.name

    }
  }
}

output "nsg_ids" {
  description = "The IDs of the network security groups"
  value       = { for k, v in azurerm_network_security_group.nsg : k => v.id }
}

output "route_table_ids" {
  description = "The IDs of the route tables"
  value       = { for k, v in module.route_table : k => v.resource_id }
}

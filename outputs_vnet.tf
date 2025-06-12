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
  description = "Detailed information about each subnet."
  value = {
    for subnet in module.avm_res_network_virtualnetwork.subnets : subnet.name => {
      resource_id                                   = subnet.resource_id
      name                                          = subnet.name
      address_prefix                                = subnet.address_prefix
      default_gateway                               = cidrhost(subnet.address_prefix, 1)
      network_security_group_id                     = subnet.network_security_group_id
      route_table_id                                = subnet.route_table_id
      service_endpoints                             = subnet.service_endpoints
      delegation                                    = try(subnet.delegation, null)
      private_endpoint_network_policies_enabled     = try(subnet.private_endpoint_network_policies_enabled, null)
      private_link_service_network_policies_enabled = try(subnet.private_link_service_network_policies_enabled, null)
      nat_gateway_id                                = try(subnet.nat_gateway_id, null)
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

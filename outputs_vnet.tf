output "vnet_resource_id" {
  description = "The resource ID of the virtual network."
  value       = module.avm_res_network_virtualnetwork.resource_id
}

output "resource_group_name" {
  description = "The name of the resource group where the virtual network is created."
  value       = var.resource_group_name
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
      address_prefix                                = try(subnet.resource.body.properties.addressPrefixes[0], null)
      address_prefixes                              = try(subnet.resource.body.properties.addressPrefixes, [])
      default_gateway                               = try(cidrhost(subnet.resource.body.properties.addressPrefixes[0], 1), null)
      network_security_group_id                     = try(subnet.resource.body.properties.networkSecurityGroup.id, null)
      route_table_id                                = try(subnet.resource.body.properties.routeTable.id, null)
      delegation                                    = try(subnet.resource.body.properties.delegations, null)
      delegated_service_name                        = try(subnet.resource.body.properties.delegations[0].properties.serviceName, null)
      private_endpoint_network_policies_enabled     = try(subnet.resource.body.properties.privateEndpointNetworkPolicies, null)
      private_link_service_network_policies_enabled = try(subnet.resource.body.properties.privateLinkServiceNetworkPolicies, null)
      service_endpoints                             = try([for s in subnet.resource.body.properties.serviceEndpoints : s.service], [])
      nat_gateway_id                                = try(subnet.resource.body.properties.natGateway.id, null)
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

module "route_table" {
  source                        = "Azure/avm-res-network-routetable/azurerm"
  version                       = "0.4.1"
  for_each                      = var.enable_route_tables ? { for k, v in var.subnets : k => v if k != "AzureBastionSubnet" } : {}
  name                          = "rt-${var.vnet_name}-${each.value.name}"
  location                      = var.azure_location
  resource_group_name           = var.resource_group_name
  enable_telemetry              = var.enable_telemetry
  bgp_route_propagation_enabled = each.value.bgp_route_propagation_enabled
  routes = {
    for route_name in try(each.value.route_names, []) :
    route_name => {
      name                   = var.routes[route_name].name
      address_prefix         = var.routes[route_name].address_prefix
      next_hop_type          = var.routes[route_name].next_hop_type
      next_hop_in_ip_address = try(var.routes[route_name].next_hop_in_ip_address, null)
    }
  }
  tags = var.azure_resource_tags
}

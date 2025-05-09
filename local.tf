locals {
  subnets = {
    for k, v in var.subnets : k => merge(
      v,

      // ONLY assign NSG if it's NOT AzureBastionSubnet
      (
        v.name != "AzureBastionSubnet" && contains(keys(azurerm_network_security_group.nsg), k)
        ) ? {
        network_security_group = {
          id = azurerm_network_security_group.nsg[k].id
        }
      } : {},

      // ONLY assign route table if it's NOT AzureBastionSubnet and routing is enabled
      (
        v.name != "AzureBastionSubnet" && var.enable_route_tables && contains(keys(module.route_table), k)
        ) ? {
        route_table = {
          id = module.route_table[k].resource.id
        }
      } : {}
    )
  }

  common_routes = {
    "UDR-Default-Internet" = {
      name           = "UDR-Default-0.0.0.0_0"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }

    "UDR-Default-Firewall" = {
      name                   = "UDR-Default-0.0.0.0_0"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = local.firewall_ip_address
    }

    "UDR-VNET-MicroSegment" = {
      name                   = "UDR-VNET-${replace(tolist(var.address_space)[0], "/", "_")}"
      address_prefix         = tolist(var.address_space)[0]
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = local.firewall_ip_address
    }
  }

  firewall_ip_address = var.firewall_ip_address != null ? var.firewall_ip_address : null

  subnet_routes = {
    # Add the microsegmentation route for each subnet

    for k, v in local.subnets : k => merge(

      {
        "UDR-SubnetMicroSegment-${v.name}" = {
          name                   = "UDR-SubnetMicroSegRoute-${v.name}"
          address_prefix         = v.address_prefixes[0] # Assuming first prefix
          next_hop_type          = "VirtualAppliance"
          next_hop_in_ip_address = local.firewall_ip_address
        }
      },
      {
        "UDR-SubnetToSelf-${v.name}" = {
          name           = "UDR-SubnetToSelf-${replace(tolist(v.address_prefixes)[0], "/", "_")}"
          address_prefix = v.address_prefixes[0] # Assuming first prefix
          next_hop_type  = "VnetLocal"
        }
      }
    )
  }

  routes = merge(
    # Flatten subnet_routes into a single map
    merge([
      for subnet, routes in local.subnet_routes : routes
    ]...),
    # Merge with common routes
    local.common_routes,
    var.routes,
  )

}

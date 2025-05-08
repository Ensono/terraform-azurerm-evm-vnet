locals {
  subnets = {
    for k, v in var.subnets : k => merge(
      v,
      contains(keys(azurerm_network_security_group.nsg), k) ? { network_security_group = { id = azurerm_network_security_group.nsg[k].id } } : {},
      var.enable_route_tables == true && contains(keys(module.route_table), k) ? { route_table = { id = module.route_table[k].resource.id } } : {}
    )
  }
}

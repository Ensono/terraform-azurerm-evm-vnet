module "example" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.modules["example"].name
  azure_location      = azurerm_resource_group.modules["example"].location
  vnet_name           = module.naming["example"].virtual_network.name
  address_space       = var.address_space
  subnets             = var.subnets
  nsg_rules           = var.nsg_rules
  routes              = var.routes
  storageaccount_name = module.naming["example"].storage_account.name
  azure_resource_tags = local.resource_tags
  enable_route_tables = var.enable_route_tables
}

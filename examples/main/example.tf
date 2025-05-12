module "example" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.this.name
  azure_location      = azurerm_resource_group.this.location
  vnet_name           = module.naming_ptn_01.virtual_network.name_unique
  address_space       = var.address_space
  subnets             = var.subnets
  nsg_rules           = var.nsg_rules
  routes              = var.routes
  storageaccount_name = module.naming_ptn_01.storage_account.name_unique
  azure_resource_tags = local.resource_tags
  enable_route_tables = var.enable_route_tables
}

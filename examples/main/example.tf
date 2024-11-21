
module "example" {
  source = "../../"

  naming_map           = module.naming["example"]
  resource_group_name  = azurerm_resource_group.modules["example"].name
  azure_location       = azurerm_resource_group.modules["example"].location
  azure_location_zones = module.azure_locations.regions_by_name[var.azure_location].zones
  azure_resource_tags  = local.resource_tags
}

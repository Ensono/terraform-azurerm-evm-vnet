module "azure_locations" {
  source  = "azure/avm-utl-regions/azurerm"
  version = "0.3.0"

  enable_telemetry   = false
  geography_filter   = var.azure_geography
  recommended_filter = false
}

resource "azurerm_resource_group" "modules" {
  for_each = var.module_names

  name     = module.naming[each.key].resource_group.name
  location = module.azure_locations.regions_by_name[var.azure_location].name

  tags = local.resource_tags
}

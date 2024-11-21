module "azure_region_names" {
  source  = "claranet/regions/azurerm"
  version = "7.2.1"

  azure_region = module.azure_locations.regions_by_name[var.azure_location].name
}

module "naming" {
  for_each = var.module_names

  source  = "azure/naming/azurerm"
  version = "0.4.1"

  suffix = tolist(
    [
      var.company_name,
      module.azure_region_names.location_short,
      var.environment_name,
      var.subscription_short_name,
      each.key,
      var.resource_suffix_name
    ]
  )
}

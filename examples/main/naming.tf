module "azure_region_names" {
  source  = "claranet/regions/azurerm"
  version = "7.2.1"

  azure_region = var.azure_location
}

module "naming" {
  for_each = var.module_names

  source  = "azure/naming/azurerm"
  version = "0.4.1"

  suffix = tolist(
    [
      var.company_name_short,
      module.azure_region_names.location_short,
      terraform.workspace,
      var.subscription_name_short,
      each.key
    ]
  )
}

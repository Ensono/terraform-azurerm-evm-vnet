resource "random_id" "naming" {
  byte_length = 10
}
module "naming_ptn_01" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"

  suffix = tolist(
    [
      var.company_name_short,
      module.azure_regions.regions_by_name[var.azure_location].geo_code,
      terraform.workspace,
      var.landing_zone_name_short
    ]
  )

  unique-seed   = random_id.naming.dec
  unique-length = 3
}

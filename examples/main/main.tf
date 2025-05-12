resource "azurerm_resource_group" "this" {
  name     = module.naming_ptn_01.resource_group.name_unique
  location = var.azure_location

  tags = local.resource_tags
}

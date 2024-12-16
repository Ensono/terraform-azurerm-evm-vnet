
# module "example" {
#   source = "../../"

#   resource_group_name  = azurerm_resource_group.modules["example"].name
#   azure_location       = azurerm_resource_group.modules["example"].location
#   azure_location_zones = data.azurerm_location.this.zone_mappings[*].logical_zone
#   azure_resource_tags  = local.resource_tags
# }

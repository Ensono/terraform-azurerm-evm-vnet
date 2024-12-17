resource "azurerm_resource_group" "modules" {
  for_each = var.module_names

  name     = module.naming[each.key].resource_group.name
  location = var.azure_location

  tags = local.resource_tags
}

resource "azurerm_management_lock" "modules" {
  for_each = var.azure_resource_group_management_lock_level != "" ? var.module_names : []

  name       = "resource-group-level"
  scope      = azurerm_resource_group.modules[each.key].id
  lock_level = var.azure_resource_group_management_lock_level
  notes      = "This Resource Group is ${var.azure_resource_group_management_lock_level}"
}

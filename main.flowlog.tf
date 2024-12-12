module "azure_region" {
  source       = "claranet/regions/azurerm"
  azure_region = var.location
}

resource "azurerm_network_watcher_flow_log" "flow_log" {
  for_each                  = var.flow_log_enabled ? { for k, v in var.subnets : k => v if k != "GatewaySubnet" && k != "AzureFirewallSubnet" && k != "AzureBastionSubnet" && k != "AzureFirewallManagementSubnet" } : {}
  network_watcher_name      = "NetworkWatcher_${module.azure_region.location_cli}"
  resource_group_name       = "NetworkWatcherRG"
  name                      = "flow-log-${var.vnet_name}-${each.value.name}"
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
  storage_account_id        = module.avm-res-storage-storageaccount[0].resource_id
  enabled                   = var.flow_log_logging_enabled
  retention_policy {
    enabled = var.flow_log_retention_policy_enabled
    days    = var.flow_log_retention_policy_days
  }
  tags = var.tags
}

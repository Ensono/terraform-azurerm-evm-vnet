module "avm_res_storage_storageaccount" {
  count                             = var.flow_log_enabled ? 1 : 0
  source                            = "Azure/avm-res-storage-storageaccount/azurerm"
  version                           = "0.4.0"
  resource_group_name               = var.resource_group_name
  location                          = var.azure_location
  account_replication_type          = var.account_replication_type
  account_tier                      = var.account_tier
  account_kind                      = var.account_kind
  access_tier                       = var.access_tier
  name                              = var.storageaccount_name
  https_traffic_only_enabled        = var.https_traffic_only_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  allow_nested_items_to_be_public   = var.allow_nested_items_to_be_public
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  shared_access_key_enabled         = var.shared_access_key_enabled
  min_tls_version                   = var.min_tls_version
  network_rules                     = var.network_rules
  enable_telemetry                  = var.enable_telemetry
  nfsv3_enabled                     = var.nfsv3_enabled
  public_network_access_enabled     = var.public_network_access_enabled
  tags                              = var.azure_resource_tags
}

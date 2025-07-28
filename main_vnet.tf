module "avm_res_network_virtualnetwork" {
  source                  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version                 = "0.9.3"
  resource_group_name     = var.resource_group_name
  location                = var.azure_location
  name                    = var.vnet_name
  enable_telemetry        = var.enable_telemetry
  address_space           = var.address_space
  dns_servers             = var.dns_servers
  enable_vm_protection    = var.enable_vm_protection
  encryption              = var.encryption
  flow_timeout_in_minutes = var.flow_timeout_in_minutes
  bgp_community           = var.bgp_community
  ddos_protection_plan    = var.ddos_protection_plan
  subnets                 = local.subnets
  tags                    = var.azure_resource_tags
  subscription_id         = var.subscription_id
}

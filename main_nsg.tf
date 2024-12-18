
resource "azurerm_network_security_group" "nsg" {
  for_each            = { for k, v in var.subnets : k => v if k != "GatewaySubnet" && k != "AzureFirewallSubnet" && k != "AzureFirewallManagementSubnet" }
  name                = "nsg-${var.vnet_name}-${each.value.name}"
  location            = var.azure_location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = { for rule_name in each.value.nsg_rule_names : rule_name => var.nsg_rules[rule_name] }

    content {
      name                                       = security_rule.value.name
      priority                                   = security_rule.value.priority
      direction                                  = security_rule.value.direction
      access                                     = security_rule.value.access
      protocol                                   = security_rule.value.protocol
      source_port_range                          = security_rule.value.source_port_range
      source_port_ranges                         = security_rule.value.source_port_ranges
      destination_port_range                     = security_rule.value.destination_port_range
      destination_port_ranges                    = security_rule.value.destination_port_ranges
      source_address_prefix                      = security_rule.value.source_address_prefix
      source_address_prefixes                    = security_rule.value.source_address_prefixes
      source_application_security_group_ids      = security_rule.value.source_application_security_group_ids
      destination_address_prefix                 = security_rule.value.destination_address_prefix
      destination_address_prefixes               = security_rule.value.destination_address_prefixes
      destination_application_security_group_ids = security_rule.value.destination_application_security_group_ids
      description                                = security_rule.value.description
    }
  }
  tags = var.azure_resource_tags
}

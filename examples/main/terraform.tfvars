/*
  sensitive inputs - DO NOT COMMIT WITH VALUES
  azure_subscription_id
*/

azure_subscription_id = "xxx"

vnet_name     = "example-vnet"
address_space = ["10.0.0.0/16"]
subnets = {
  subnet1 = {
    name                                          = "subnet-test-inbound"
    address_prefixes                              = ["10.0.1.0/24"]
    default_outbound_access_enabled               = true
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    service_endpoints                             = ["Microsoft.Storage", "Microsoft.KeyVault"]
    nsg_rule_names                                = ["allow_http", "allow_multiple_destinations", "deny_all_inbound"]

  }
  subnet2 = {
    name                                          = "subnet-test-outbound"
    address_prefixes                              = ["10.0.2.0/24"]
    default_outbound_access_enabled               = true
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    delegation = [{
      name = "Microsoft.Web.serverFarms"
      service_delegation = {
        name = "Microsoft.Web/serverFarms"
      }
    }]
    service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    nsg_rule_names    = []
    route_names       = []

  }
  subnet3 = {
    name                                          = "pvt-subnet"
    address_prefixes                              = ["10.0.3.0/24"]
    default_outbound_access_enabled               = true
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = true
    service_endpoints                             = ["Microsoft.Storage", "Microsoft.KeyVault"]
    nsg_rule_names                                = ["allow_http", "allow_ssh", "deny_all_outbound"]
  }
  GatewaySubnet = {
    name                                          = "GatewaySubnet"
    address_prefixes                              = ["10.0.4.0/27"]
    default_outbound_access_enabled               = false
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = false
    bgp_route_propagation_enabled                 = false
  }
  AzureFirewallSubnet = {
    name                                          = "AzureFirewallSubnet"
    address_prefixes                              = ["10.0.5.0/26"]
    default_outbound_access_enabled               = false
    private_endpoint_network_policies             = "Disabled"
    route_names                                   = ["Default"]
    private_link_service_network_policies_enabled = false
    route_names                                   = ["Default"]
  }
  AzureBastionSubnet = {
    name                                          = "AzureBastionSubnet"
    address_prefixes                              = ["10.0.10.0/24"]
    default_outbound_access_enabled               = false
    private_endpoint_network_policies             = "Disabled"
    route_names                                   = ["Default"]
    private_link_service_network_policies_enabled = false
    route_names                                   = ["Default"]
    nsg_rule_names                                = ["allow_http", "allow_ssh", "deny_all_outbound"]
  }
}

nsg_rules = {
  allow_ssh = {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  allow_http = {
    name                       = "allow_http"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  allow_https = {
    name                       = "allow_https"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  allow_rdp = {
    name                       = "allow_rdp"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  deny_all_outbound = {
    name                       = "deny_all_outbound"
    priority                   = 600
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  allow_multiple_destinations = {
    name                         = "allow_multiple_destinations"
    priority                     = 900
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "8080"
    source_address_prefix        = "*"
    destination_address_prefixes = ["10.0.0.7", "10.0.0.8"]
  }
  deny_all_inbound = {
    name                       = "deny_all_inbound"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

routes = {
  Default = {
    name           = "Default"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}

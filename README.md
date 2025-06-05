# Ensono Verified Module (EVM) - Azure Terraform VNET

An Azure Terraform Ensono Verified Module (EVM) designed to abstract the complexity of provisioning resources related to Azure Virtual Networks, Subnets, NSGs and Routes.

<!-- BEGIN_TF_DOCS -->
## Contributing

This repository uses the [pre-commit](https://pre-commit.com/) git hook framework which can update and format some files enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

Examples can be found at the bottom taken from the [examples](./examples) directory.

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| avm\_res\_network\_virtualnetwork | Azure/avm-res-network-virtualnetwork/azurerm | 0.8.1 |
| route\_table | Azure/avm-res-network-routetable/azurerm | 0.4.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_space | The address spaces applied to the virtual network. You can supply more than one address space. | `set(string)` | n/a | yes |
| azure\_location | The Azure target location for all resources managed by this module. | `string` | n/a | yes |
| azure\_resource\_tags | Resource tags to add to all resources managed by this module. | `map(string)` | n/a | yes |
| bgp\_community | (Optional) The BGP community to send to the virtual network gateway. | `string` | `null` | no |
| ddos\_protection\_plan | Specifies an AzureNetwork DDoS Protection Plan.<br/><br/>- `id`: The ID of the DDoS Protection Plan. (Required)<br/>- `enable`: Enables or disables the DDoS Protection Plan on the Virtual Network. (Required) | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| dns\_servers | (Optional) Specifies a list of IP addresses representing DNS servers.<br/><br/>- `dns_servers`: Set of IP addresses of DNS servers. | <pre>object({<br/>    dns_servers = set(string)<br/>  })</pre> | `null` | no |
| enable\_route\_tables | Optional: Deploy route tables for subnets. This cannot be changed after the module is created, to change this value, the module must be destroyed and recreated. | `bool` | `true` | no |
| enable\_telemetry | This variable controls whether or not telemetry is enabled for the module. | `bool` | `false` | no |
| enable\_vm\_protection | Enable VM Protection for the virtual network | `bool` | `false` | no |
| encryption | (Optional) Specifies the encryption settings for the virtual network. | <pre>object({<br/>    enabled     = bool<br/>    enforcement = string<br/>  })</pre> | `null` | no |
| flow\_timeout\_in\_minutes | The flow timeout in minutes for the virtual network | `number` | `null` | no |
| nsg\_rules | A map of NSG rules | <pre>map(object({<br/>    name                                       = string<br/>    priority                                   = number<br/>    direction                                  = string<br/>    access                                     = string<br/>    protocol                                   = string<br/>    source_port_range                          = optional(string, "")<br/>    source_port_ranges                         = optional(list(string), [])<br/>    destination_port_range                     = optional(string, "")<br/>    destination_port_ranges                    = optional(list(string), [])<br/>    source_address_prefix                      = optional(string, "")<br/>    source_address_prefixes                    = optional(list(string), [])<br/>    source_application_security_group_ids      = optional(list(string), [])<br/>    destination_address_prefix                 = optional(string, "")<br/>    destination_address_prefixes               = optional(list(string), [])<br/>    destination_application_security_group_ids = optional(list(string), [])<br/>    description                                = optional(string, "")<br/>  }))</pre> | `{}` | no |
| resource\_group\_name | Resource group name for all resources managed by this module. | `string` | n/a | yes |
| routes | (Optional) A map of route objects to create on the route table. | <pre>map(object({<br/>    name                   = string<br/>    address_prefix         = string<br/>    next_hop_type          = string<br/>    next_hop_in_ip_address = optional(string)<br/>  }))</pre> | `{}` | no |
| subnets | A map of subnets to create | <pre>map(object({<br/>    name                                          = string<br/>    address_prefixes                              = list(string)<br/>    default_outbound_access_enabled               = optional(bool, true)<br/>    private_endpoint_network_policies             = optional(string, "Disabled")<br/>    private_link_service_network_policies_enabled = optional(bool, true)<br/>    delegation = optional(list(object({<br/>      name = string<br/>      service_delegation = object({<br/>        name = string<br/>      })<br/>    })))<br/>    service_endpoints             = optional(list(string))<br/>    nsg_rule_names                = optional(list(string), [])<br/>    route_names                   = optional(list(string), [])<br/>    bgp_route_propagation_enabled = optional(bool, true) # Option to enable BGP route propagation for its Route Table.<br/>  }))</pre> | n/a | yes |
| subscription\_id | (Optional) Subscription ID passed in by an external process.  If this is not supplied, then the configuration either needs to include the subscription ID, or needs to be supplied properties to create the subscription. | `string` | `null` | no |
| vnet\_name | The name of the virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| nsg\_ids | The IDs of the network security groups |
| route\_table\_ids | The IDs of the route tables |
| subnets | Information about the subnets created in the module. |
| vnet\_name | The resource name of the virtual network. |
| vnet\_resource\_id | The resource ID of the virtual network. |

## Examples

### Main

#### terraform.tfvars

```hcl
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
```

#### example.tf

```hcl
module "example" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.this.name
  azure_location      = azurerm_resource_group.this.location
  vnet_name           = module.naming_ptn_01.virtual_network.name_unique
  address_space       = var.address_space
  subnets             = var.subnets
  nsg_rules           = var.nsg_rules
  routes              = var.routes
  azure_resource_tags = local.resource_tags
  enable_route_tables = var.enable_route_tables
}
```
<!-- END_TF_DOCS -->

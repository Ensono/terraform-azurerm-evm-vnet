# Ensono Verified Module (EVM) - Azure Terraform VNET

An Azure Terraform Ensono Verified Module (EVM) designed to abstract the complexity of provisioning resources related to Azure Virtual Networks, Subnets, NSGs and Routes.

## Contributing

This repository uses the [pre-commit](https://pre-commit.com/) git hook framework, which can update and format some files enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

Examples can be found in the [examples](./examples/) directory.

<!-- BEGIN_TF_DOCS -->
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
<!-- END_TF_DOCS -->

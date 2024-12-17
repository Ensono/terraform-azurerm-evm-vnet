# Ensono Verified Module (EVM) - Azure Terraform [REPLACE WITH MODULE NAME]
An Azure Terraform Ensono Verified Module (EVM) designed to abstract the complexity of provisioning resources related to Azure Virtual Networks, Subnets, NSGs, Routes and Flowlogs.

---

<!-- BEGIN_TF_DOCS -->
## Contributing
This repository uses the [pre-commit](https://pre-commit.com/) git hook framework which can update and format some files enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage
Examples can be found at the bottom taken from the `examples` directory.


## Providers

| Name | Version |
|------|---------|
| azurerm | >= 3.117.0, < 5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| avm\_res\_network\_virtualnetwork | Azure/avm-res-network-virtualnetwork/azurerm | 0.7.1 |
| avm\_res\_storage\_storageaccount | Azure/avm-res-storage-storageaccount/azurerm | 0.2.9 |
| route\_table | Azure/avm-res-network-routetable/azurerm | 0.3.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_watcher_flow_log.flow_log](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_watcher_flow_log) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_tier | (Optional) Defines the access tier for `BlobStorage`, `FileStorage` and `StorageV2` accounts. Valid options are `Hot` and `Cool`, defaults to `Hot`. | `string` | `"Hot"` | no |
| account\_kind | (Optional) Defines the Kind of account. Valid options are `BlobStorage`, `BlockBlobStorage`, `FileStorage`, `Storage` and `StorageV2`. Defaults to `StorageV2`. | `string` | `"StorageV2"` | no |
| account\_replication\_type | (Required) Defines the type of replication to use for this storage account. Valid options are `LRS`, `GRS`, `RAGRS`, `ZRS`, `GZRS` and `RAGZRS`.  Defaults to `ZRS` | `string` | `"LRS"` | no |
| account\_tier | (Required) Defines the Tier to use for this storage account. Valid options are `Standard` and `Premium`. For `BlockBlobStorage` and `FileStorage` accounts only `Premium` is valid. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| address\_space | The address spaces applied to the virtual network. You can supply more than one address space. | `set(string)` | n/a | yes |
| allow\_nested\_items\_to\_be\_public | (Optional) Allow or disallow nested items within this Account to opt into being public. Defaults to `false`. | `bool` | `true` | no |
| azure\_location | The Azure target location for all resources managed by this module. | `string` | n/a | yes |
| azure\_resource\_tags | Resource tags to add to all resources managed by this module. | `map(string)` | n/a | yes |
| bgp\_community | (Optional) The BGP community to send to the virtual network gateway. | `string` | `null` | no |
| cross\_tenant\_replication\_enabled | (Optional) Should cross Tenant replication be enabled? Defaults to `false`. | `bool` | `true` | no |
| ddos\_protection\_plan | Specifies an AzureNetwork DDoS Protection Plan.<br/><br/>- `id`: The ID of the DDoS Protection Plan. (Required)<br/>- `enable`: Enables or disables the DDoS Protection Plan on the Virtual Network. (Required) | <pre>object({<br/>    id     = string<br/>    enable = bool<br/>  })</pre> | `null` | no |
| default\_to\_oauth\_authentication | (Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is `false` | `bool` | `false` | no |
| dns\_servers | (Optional) Specifies a list of IP addresses representing DNS servers.<br/><br/>- `dns_servers`: Set of IP addresses of DNS servers. | <pre>object({<br/>    dns_servers = set(string)<br/>  })</pre> | `null` | no |
| enable\_telemetry | This variable controls whether or not telemetry is enabled for the module. | `bool` | `false` | no |
| enable\_vm\_protection | Enable VM Protection for the virtual network | `bool` | `false` | no |
| encryption | (Optional) Specifies the encryption settings for the virtual network. | <pre>object({<br/>    enabled     = bool<br/>    enforcement = string<br/>  })</pre> | `null` | no |
| flow\_log\_enabled | Provision network watcher flow logs. | `bool` | `true` | no |
| flow\_log\_logging\_enabled | Enable Network Flow Logging. | `bool` | `true` | no |
| flow\_log\_retention\_policy\_days | The number of days to retain flow log records. | `number` | `91` | no |
| flow\_log\_retention\_policy\_enabled | Boolean flag to enable/disable retention. | `bool` | `true` | no |
| flow\_timeout\_in\_minutes | The flow timeout in minutes for the virtual network | `number` | `null` | no |
| https\_traffic\_only\_enabled | (Optional) Boolean flag which forces HTTPS if enabled, see [here](https://docs.microsoft.com/azure/storage/storage-require-secure-transfer/) for more information. Defaults to `true`. | `bool` | `true` | no |
| infrastructure\_encryption\_enabled | (Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to `false`. | `bool` | `false` | no |
| min\_tls\_version | (Optional) The minimum supported TLS version for the storage account. Possible values are `TLS1_0`, `TLS1_1`, and `TLS1_2`. Defaults to `TLS1_2` for new storage accounts. | `string` | `"TLS1_2"` | no |
| network\_rules | > Note the default value for this variable will block all public access to the storage account. If you want to disable all network rules, set this value to `null`.<br/><br/>- `bypass` - (Optional) Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of `Logging`, `Metrics`, `AzureServices`, or `None`.<br/>- `default_action` - (Required) Specifies the default action of allow or deny when no other rules match. Valid options are `Deny` or `Allow`.<br/>- `ip_rules` - (Optional) List of public IP or IP ranges in CIDR Format. Only IPv4 addresses are allowed. Private IP address ranges (as defined in [RFC 1918](https://tools.ietf.org/html/rfc1918#section-3)) are not allowed.<br/>- `storage_account_id` - (Required) Specifies the ID of the storage account. Changing this forces a new resource to be created.<br/>- `virtual_network_subnet_ids` - (Optional) A list of virtual network subnet ids to secure the storage account.<br/><br/>---<br/>`private_link_access` block supports the following:<br/>- `endpoint_resource_id` - (Required) The resource id of the resource access rule to be granted access.<br/>- `endpoint_tenant_id` - (Optional) The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.<br/><br/>---<br/>`timeouts` block supports the following:<br/>- `create` - (Defaults to 60 minutes) Used when creating the  Network Rules for this Storage Account.<br/>- `delete` - (Defaults to 60 minutes) Used when deleting the Network Rules for this Storage Account.<br/>- `read` - (Defaults to 5 minutes) Used when retrieving the Network Rules for this Storage Account.<br/>- `update` - (Defaults to 60 minutes) Used when updating the Network Rules for this Storage Account. | <pre>object({<br/>    bypass                     = optional(set(string), ["AzureServices"])<br/>    default_action             = optional(string, "Deny")<br/>    ip_rules                   = optional(set(string), [])<br/>    virtual_network_subnet_ids = optional(set(string), [])<br/>    private_link_access = optional(list(object({<br/>      endpoint_resource_id = string<br/>      endpoint_tenant_id   = optional(string)<br/>    })))<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      delete = optional(string)<br/>      read   = optional(string)<br/>      update = optional(string)<br/>    }))<br/>  })</pre> | `null` | no |
| nfsv3\_enabled | (Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created. Defaults to `false`. | `bool` | `false` | no |
| nsg\_rules | A map of NSG rules | <pre>map(object({<br/>    name                                       = string<br/>    priority                                   = number<br/>    direction                                  = string<br/>    access                                     = string<br/>    protocol                                   = string<br/>    source_port_range                          = optional(string, "")<br/>    source_port_ranges                         = optional(list(string), [])<br/>    destination_port_range                     = optional(string, "")<br/>    destination_port_ranges                    = optional(list(string), [])<br/>    source_address_prefix                      = optional(string, "")<br/>    source_address_prefixes                    = optional(list(string), [])<br/>    source_application_security_group_ids      = optional(list(string), [])<br/>    destination_address_prefix                 = optional(string, "")<br/>    destination_address_prefixes               = optional(list(string), [])<br/>    destination_application_security_group_ids = optional(list(string), [])<br/>    description                                = optional(string, "")<br/>  }))</pre> | `{}` | no |
| public\_network\_access\_enabled | (Optional) Whether the public network access is enabled? Defaults to `false`. | `bool` | `true` | no |
| resource\_group\_name | Resource group name for all resources managed by this module. | `string` | n/a | yes |
| routes | (Optional) A map of route objects to create on the route table. | <pre>map(object({<br/>    name                   = string<br/>    address_prefix         = string<br/>    next_hop_type          = string<br/>    next_hop_in_ip_address = optional(string)<br/>  }))</pre> | `{}` | no |
| shared\_access\_key\_enabled | (Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is `false`. | `bool` | `true` | no |
| storageaccount\_name | The name of the resource. | `string` | `"defaultstorageacct"` | no |
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
company_name_short      = "ens"
subscription_name_short = "sub"
module_names            = ["example"]
azure_location          = "uksouth"

/*
Sensitive inputs should be passed as pipeline environment variables

azure_subscription_id = "xxx"
*/

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
    # nsg_rule_names                                = ["allow_https", "allow_rdp"]
    nsg_rule_names = []
    route_names    = []

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
    address_prefixes                              = ["10.0.6.0/26"]
    default_outbound_access_enabled               = false
    private_endpoint_network_policies             = "Disabled"
    private_link_service_network_policies_enabled = false

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

# module "example" {
#   source = "../../"

#   resource_group_name  = azurerm_resource_group.modules["example"].name
#   azure_location       = azurerm_resource_group.modules["example"].location
#   azure_location_zones = data.azurerm_location.this.zone_mappings[*].logical_zone
#   azure_resource_tags  = local.resource_tags
# }


module "example" {
  source              = "../../"
  resource_group_name = azurerm_resource_group.modules["example"].name
  azure_location      = azurerm_resource_group.modules["example"].location
  vnet_name           = module.naming["example"].virtual_network.name
  address_space       = var.address_space
  subnets             = var.subnets
  nsg_rules           = var.nsg_rules
  routes              = var.routes
  storageaccount_name = module.naming["example"].storage_account.name
  azure_resource_tags = local.resource_tags
}
```
<!-- END_TF_DOCS -->

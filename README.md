# Ensono Verified Module (EVM) - Azure Terraform [REPLACE WITH MODULE NAME]
An Azure Terraform Ensono Verified Module (EVM) designed to abstract the complexity of provisioning resources related to [ADD SHORT DESCRIPTION OF WHAT THE MODULE DOES].

---

<!-- BEGIN_TF_DOCS -->
## Contributing
This repository uses the [pre-commit](https://pre-commit.com/) git hook framework which can update and format some files enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage
Examples can be found at the bottom taken from the `examples` directory.


## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_location | The Azure target location for all resources managed by this module. | `string` | n/a | yes |
| azure\_location\_zones | The Azure target location available zones | `set(number)` | n/a | yes |
| azure\_resource\_tags | Resource tags to add to all resources managed by this module. | `map(string)` | n/a | yes |
| naming\_map | A map containing Azure resource anmes aligned to the Cloud Adoption Framework. | `any` | n/a | yes |
| resource\_group\_name | Resource group name for all resources managed by this module. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| azure\_location | DELETE: temporary to satisfy TFLint rules |
| azure\_location\_zones | DELETE: temporary to satisfy TFLint rules |
| azure\_resource\_tags | DELETE: temporary to satisfy TFLint rules |
| naming\_map | DELETE: temporary to satisfy TFLint rules |
| resource\_group\_name | DELETE: temporary to satisfy TFLint rules |

## Examples
### Main
#### terraform.tfvars
```hcl
company_name            = "ens"
project_name            = "evm"
environment_name        = "ci"
subscription_short_name = "sub"
resource_suffix_name    = "main"
module_names            = ["root", "example"]
azure_geography         = "United Kingdom"
azure_location          = "uksouth"

/*
Sensitive inputs should be passed as pipeline environment variables

azure_default_provider_subscription_id = "xxx"
*/
```

#### example.tf
```hcl

module "example" {
  source = "../../"

  naming_map           = module.naming["example"]
  resource_group_name  = azurerm_resource_group.modules["example"].name
  azure_location       = azurerm_resource_group.modules["example"].location
  azure_location_zones = module.azure_locations.regions_by_name[var.azure_location].zones
  azure_resource_tags  = local.resource_tags
}
```
<!-- END_TF_DOCS -->

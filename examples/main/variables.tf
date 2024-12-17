
# Naming
variable "company_name_short" {
  description = "Company short name which can be used in naming and tagging of resources."
  type        = string
  sensitive   = false
}

variable "subscription_name_short" {
  description = "Subscription short name which can be used in naming and tagging of resources."
  type        = string
  sensitive   = false
}

variable "module_names" {
  description = "An list of module names which can be used in naming and tagging of resources used with different module calls."
  type        = set(string)
  sensitive   = false
}

# Azure
variable "azure_subscription_id" {
  description = "The Azure subscription id used on the default azurerm provider."
  type        = string
  sensitive   = false
}

variable "azure_location" {
  description = "The Azure location to target all resources."
  type        = string
  sensitive   = false
}


variable "azure_resource_group_management_lock_level" {
  description = "Optional: The level of Management Lock apply to Resource Groups"
  type        = string
  sensitive   = false
  default     = ""

  validation {
    condition = contains([
      "",
      "ReadOnly",
      "CanNotDelete"
    ], var.azure_resource_group_management_lock_level)
    error_message = "Possible values are 'ReadOnly' or 'CanNotDelete'."
  }
}

variable "azure_resource_tags" {
  description = "Optional: Resource tags to add to all resources managed by this module."
  type        = map(string)
  sensitive   = false
  default     = {}
}

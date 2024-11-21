
# Naming
variable "company_name" {
  description = "Company name which can be used in naming and tagging of resources."
  type        = string
  sensitive   = false
}

variable "project_name" {
  description = "Project name which can be used in naming and tagging of resources."
  type        = string
  sensitive   = false
}

variable "environment_name" {
  description = "Environment name which can be used in naming and tagging of resources."
  type        = string
  sensitive   = false
}

variable "subscription_short_name" {
  description = "Subscription short name which can be used in naming and tagging of resources."
  type        = string
  sensitive   = false
}

variable "resource_suffix_name" {
  description = "A suffix to append to all resources managed by this module."
  type        = string
  sensitive   = false
}

variable "module_names" {
  description = "An list of module names which can be used in naming and tagging of resources used with different module calls."
  type        = set(string)
  sensitive   = false
}

# Azure
variable "azure_default_provider_subscription_id" {
  description = "The Azure subscription id used on the default azurerm provider."
  type        = string
  sensitive   = false
}

/*
Examples
https://datacenters.microsoft.com/globe/explore?info=geography_unitedkingdom
https://datacenters.microsoft.com/globe/explore?info=geography_europe
https://datacenters.microsoft.com/globe/explore?info=geography_unitedstates
*/
variable "azure_geography" {
  description = "The Azure geography name for the target location."
  type        = string
  sensitive   = false
}

variable "azure_location" {
  description = "The Azure location to target all resources."
  type        = string
  sensitive   = false
}


variable "azure_resource_tags" {
  description = "Optional: Resource tags to add to all resources managed by this module."
  type        = map(string)
  sensitive   = false
  default     = {}
}


variable "company_name_short" {
  description = "Company short name which can be used in naming and tagging of resources."
  type        = string
  default     = "ens"
  sensitive   = false
}

variable "landing_zone_name_short" {
  description = "Platform short name which can be used in naming and tagging of resources."
  type        = string
  default     = "evm"
  sensitive   = false
}
variable "azure_geography" {
  description = "The Azure geography name for the target location."
  type        = string
  default     = "United Kingdom"
  sensitive   = false
}
variable "azure_location" {
  description = "The Azure location to target all resources."
  type        = string
  default     = "uksouth"
  sensitive   = false
}
variable "azure_subscription_id" {
  description = "The Azure subscription id used on the default azurerm provider."
  type        = string
  sensitive   = true
}

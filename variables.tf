variable "naming_map" {
  description = "A map containing Azure resource anmes aligned to the Cloud Adoption Framework."
  type        = any
  sensitive   = false
}

variable "resource_group_name" {
  description = "Resource group name for all resources managed by this module."
  type        = string
  sensitive   = false
}

variable "azure_location" {
  description = "The Azure target location for all resources managed by this module."
  type        = string
  sensitive   = false
}

variable "azure_location_zones" {
  description = "The Azure target location available zones"
  type        = set(number)
  sensitive   = false
}


variable "azure_resource_tags" {
  description = "Resource tags to add to all resources managed by this module."
  type        = map(string)
  sensitive   = false
}

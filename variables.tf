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

variable "azure_resource_tags" {
  description = "Resource tags to add to all resources managed by this module."
  type        = map(string)
  sensitive   = false
}

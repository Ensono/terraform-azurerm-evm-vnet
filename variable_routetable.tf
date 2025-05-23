variable "routes" {
  type = map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default     = {}
  description = "(Optional) A map of route objects to create on the route table. "
}

variable "enable_route_tables" {
  description = "Optional: Deploy route tables for subnets. This cannot be changed after the module is created, to change this value, the module must be destroyed and recreated."
  type        = bool
  sensitive   = false
  default     = true
}

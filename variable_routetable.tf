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

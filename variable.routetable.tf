variable "routes" {
  type = map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = {
    Default = {
      name           = "Default"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }

  }
}

variable "bgp_route_propagation_enabled" {
  description = "Option to enable BGP route propagation on the Route Table."
  type        = bool
  default     = true
}

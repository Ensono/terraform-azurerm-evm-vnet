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

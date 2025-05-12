variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  type        = set(string)
  description = "The address spaces applied to the virtual network. You can supply more than one address space."
  nullable    = false
}

variable "subnets" {
  description = "A map of subnets to create"
  type = map(object({
    name                                          = string
    address_prefixes                              = list(string)
    default_outbound_access_enabled               = optional(bool, true)
    private_endpoint_network_policies             = optional(string, "Disabled")
    private_link_service_network_policies_enabled = optional(bool, true)
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name = string
      })
    })))
    service_endpoints             = optional(list(string))
    nsg_rule_names                = optional(list(string), [])
    route_names                   = optional(list(string), [])
    bgp_route_propagation_enabled = optional(bool, true) # Option to enable BGP route propagation for its Route Table.
  }))
}

variable "storageaccount_name" {
  type        = string
  description = "The name of the resource."
  default     = "defaultstorageacct" # Default value that meets the validation criteria. Provide a valid name if flow_log_enabled is true.
  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storageaccount_name))
    error_message = "The name must be between 3 and 24 characters, valid characters are lowercase letters and numbers."
  }
}

variable "nsg_rules" {
  description = "A map of NSG rules"
  type = map(object({
    name                                       = string
    priority                                   = number
    direction                                  = string
    access                                     = string
    protocol                                   = string
    source_port_range                          = optional(string, "")
    source_port_ranges                         = optional(list(string), [])
    destination_port_range                     = optional(string, "")
    destination_port_ranges                    = optional(list(string), [])
    source_address_prefix                      = optional(string, "")
    source_address_prefixes                    = optional(list(string), [])
    source_application_security_group_ids      = optional(list(string), [])
    destination_address_prefix                 = optional(string, "")
    destination_address_prefixes               = optional(list(string), [])
    destination_application_security_group_ids = optional(list(string), [])
    description                                = optional(string, "")
  }))
  default = {}
}

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
  description = "Optional: Enable route tables for subnets."
  type        = bool
  sensitive   = false
  default     = true
}


variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  type        = set(string)
  description = "The address spaces applied to the virtual network. You can supply more than one address space."
  nullable    = false
}

variable "dns_servers" {
  type = object({
    dns_servers = set(string)
  })
  default     = null
  description = <<DESCRIPTION
(Optional) Specifies a list of IP addresses representing DNS servers.

- `dns_servers`: Set of IP addresses of DNS servers.
DESCRIPTION
}

variable "enable_vm_protection" {
  description = "Enable VM Protection for the virtual network"
  type        = bool
  default     = false
}

variable "enable_telemetry" {
  type        = bool
  default     = false
  description = "This variable controls whether or not telemetry is enabled for the module."
}

variable "encryption" {
  type = object({
    enabled     = bool
    enforcement = string
  })
  default     = null
  description = "(Optional) Specifies the encryption settings for the virtual network."
}

variable "flow_timeout_in_minutes" {
  description = "The flow timeout in minutes for the virtual network"
  type        = number
  default     = null
}

variable "bgp_community" {
  type        = string
  default     = null
  description = <<DESCRIPTION
(Optional) The BGP community to send to the virtual network gateway.
DESCRIPTION
}

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default     = null
  description = <<DESCRIPTION
Specifies an AzureNetwork DDoS Protection Plan.

- `id`: The ID of the DDoS Protection Plan. (Required)
- `enable`: Enables or disables the DDoS Protection Plan on the Virtual Network. (Required)
DESCRIPTION
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

variable "subscription_id" {
  type        = string
  default     = null
  description = "(Optional) Subscription ID passed in by an external process.  If this is not supplied, then the configuration either needs to include the subscription ID, or needs to be supplied properties to create the subscription."
}

variable "firewall_ip_address" {
  type        = string
  default     = null
  description = "(Optional) The IP address of the firewall. This is used for routing."
}

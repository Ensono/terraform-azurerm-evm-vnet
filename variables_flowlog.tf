variable "flow_log_enabled" {
  description = "Provision network watcher flow logs."
  type        = bool
  default     = false
}

variable "flow_log_logging_enabled" {
  description = "Enable Network Flow Logging."
  type        = bool
  default     = true
}

variable "flow_log_retention_policy_enabled" {
  description = "Boolean flag to enable/disable retention."
  type        = bool
  default     = true
}

variable "flow_log_retention_policy_days" {
  description = "The number of days to retain flow log records."
  type        = number
  default     = 91
}

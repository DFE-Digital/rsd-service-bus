variable "azure_client_id" {
  description = "Service Principal Client ID"
  type        = string
}

variable "azure_client_secret" {
  description = "Service Principal Client Secret"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Service Principal Tenant ID"
  type        = string
}

variable "azure_subscription_id" {
  description = "Service Principal Subscription ID"
  type        = string
}

variable "environment" {
  description = "Environment name. Will be used along with `project_name` as a prefix for all resources."
  type        = string
}

variable "project_name" {
  description = "Project name. Will be used along with `environment` as a prefix for all resources."
  type        = string
}

variable "azure_location" {
  description = "Azure location in which to launch resources."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "service_bus_config" {
  description = "Service bus configuration with topics and subscriptions"
  type = object({
    service_buses = map(object({
      authorization_rules = optional(object({
        listen = bool
        send   = bool
        manage = bool
      }), { listen = true, send = true, manage = false })
      public_access_enabled    = optional(bool, false)
      ipv4_access_list         = optional(list(string), [])
      subnet_id_access_list    = optional(list(string), [])
      trusted_services_allowed = optional(bool, false)
      topics = map(object({
        subscriptions = map(object({
          sql_filter = optional(string, "")
        }))
      }))
    }))
  })
  default = {
    service_buses = {
    }
  }
}

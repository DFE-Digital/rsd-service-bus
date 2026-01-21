# <REPLACE WITH USEFUL TERRAFORM DESCRIPTION>

[![Terraform CI](https://github.com/DFE-Digital/rsd-service-bus/actions/workflows/continuous-integration-terraform.yml/badge.svg?branch=main)](https://github.com/DFE-Digital/rsd-service-bus/actions/workflows/continuous-integration-terraform.yml?branch=main)
[![GitHub release](https://img.shields.io/github/release/DFE-Digital/rsd-service-bus.svg)](https://github.com/DFE-Digital/rsd-service-bus/releases)

Terraform project for deploying Service Bus, Topics and subscriptions within RSD 

## Usage

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.13.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.50.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.default](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_servicebus_namespace.service_buses](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |
| [azurerm_servicebus_namespace_authorization_rule.service_buse_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule) | resource |
| [azurerm_servicebus_subscription.service_bus_topic_subscriptions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription) | resource |
| [azurerm_servicebus_subscription_rule.service_bus_topic_subscription_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_subscription_rule) | resource |
| [azurerm_servicebus_topic.service_bus_topics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | Service Principal Client ID | `string` | n/a | yes |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | Service Principal Client Secret | `string` | n/a | yes |
| <a name="input_azure_location"></a> [azure\_location](#input\_azure\_location) | Azure location in which to launch resources. | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | Service Principal Subscription ID | `string` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | Service Principal Tenant ID | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. Will be used along with `project_name` as a prefix for all resources. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name. Will be used along with `environment` as a prefix for all resources. | `string` | n/a | yes |
| <a name="input_service_bus_config"></a> [service\_bus\_config](#input\_service\_bus\_config) | Service bus configuration with topics and subscriptions | <pre>object({<br/>    service_buses = map(object({<br/>      authorization_rules = optional(object({<br/>        listen = bool<br/>        send   = bool<br/>        manage = bool<br/>      }), { listen = true, send = true, manage = false })<br/>      public_access_enabled    = optional(bool, false)<br/>      ipv4_access_list         = optional(list(string), [])<br/>      trusted_services_allowed = optional(bool, false)<br/>      topics = map(object({<br/>        subscriptions = map(object({<br/>          sql_filter = optional(string, "")<br/>        }))<br/>      }))<br/>    }))<br/>  })</pre> | <pre>{<br/>  "service_buses": {}<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment"></a> [environment](#output\_environment) | n/a |
<!-- END_TF_DOCS -->

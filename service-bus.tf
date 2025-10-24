resource "azurerm_servicebus_namespace" "service_buses" {
  for_each = local.service_bus_config["service_buses"]

  name                = "${local.resource_prefix}${each.key}"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "Standard"

  network_rule_set {
    public_network_access_enabled = each.value["public_access_enabled"]
    default_action                = each.value["public_access_enabled"] ? "Allow" : "Deny"
    ip_rules                      = each.value["public_access_enabled"] ? null : each.value["ipv4_access_list"]
    trusted_services_allowed      = each.value["trusted_services_allowed"]
    dynamic "network_rules" {
      for_each = each.value["subnet_id_access_list"]
      content {
        subnet_id = network_rules.value
      }
    }
  }
}

resource "azurerm_servicebus_namespace_authorization_rule" "service_buse_rules" {
  for_each = local.service_bus_config["service_buses"]

  name         = "${local.resource_prefix}${each.key}"
  namespace_id = azurerm_servicebus_namespace.service_buses[each.key].id
  listen       = each.value["authorization_rules"]["listen"]
  send         = each.value["authorization_rules"]["send"]
  manage       = each.value["authorization_rules"]["manage"]
}

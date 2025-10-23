resource "azurerm_servicebus_namespace" "service_buses" {
  for_each = local.service_bus_config["service_buses"]

  name                = "${local.resource_prefix}${each.key}"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  sku                 = "Standard"
}

resource "azurerm_servicebus_namespace_authorization_rule" "service_buse_rules" {
  for_each = local.service_bus_config["service_buses"]

  name         = "${local.resource_prefix}${each.key}"
  namespace_id = azurerm_servicebus_namespace.service_buses[each.key].id
  listen       = each.value["authorization_rules"]["listen"]
  send         = each.value["authorization_rules"]["send"]
  manage       = each.value["authorization_rules"]["manage"]
}

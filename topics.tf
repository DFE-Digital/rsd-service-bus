resource "azurerm_servicebus_topic" "service_bus_topics" {
  for_each = merge([
    for service_bus_name, service_bus in local.service_bus_config["service_buses"] : {
      for topic_name, topic in service_bus["topics"] : "${service_bus_name}_${topic_name}" => {
        topic_name       = topic_name
        service_bus_name = service_bus_name
      }
    }
  ]...)

  name                  = each.value["topic_name"]
  namespace_id          = azurerm_servicebus_namespace.service_buses[each.value["service_bus_name"]].id
  partitioning_enabled  = false
  max_size_in_megabytes = 1024
}

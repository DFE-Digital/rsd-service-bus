resource "azurerm_servicebus_subscription" "service_bus_topic_subscriptions" {
  for_each = merge([
    for service_bus_name, service_bus in local.service_bus_config["service_buses"] : merge([
      for topic_name, topic in service_bus["topics"] : {
        for subscription_name, subscription in topic["subscriptions"] : "${service_bus_name}_${topic_name}_${subscription_name}" => {
          service_bus_name  = service_bus_name
          subscription_name = subscription_name
          topic_name        = topic_name
        }
      }
    ]...)
  ]...)

  name                                 = each.value["subscription_name"]
  topic_id                             = azurerm_servicebus_topic.service_bus_topics["${each.value["service_bus_name"]}_${each.value["topic_name"]}"].id
  max_delivery_count                   = 10
  lock_duration                        = "PT1M"
  dead_lettering_on_message_expiration = true
}

resource "azurerm_servicebus_subscription_rule" "service_bus_topic_subscription_rules" {
  for_each = merge([
    for service_bus_name, service_bus in local.service_bus_config["service_buses"] : merge([
      for topic_name, topic in service_bus["topics"] : {
        for subscription_name, subscription in topic["subscriptions"] : "${service_bus_name}_${topic_name}_${subscription_name}" => {
          service_bus_name  = service_bus_name
          subscription_name = subscription_name
          topic_name        = topic_name
          sql_filter        = subscription["sql_filter"]
        } if subscription["sql_filter"] != ""
      }
    ]...)
  ]...)

  name            = "sqlFilterRule"
  subscription_id = azurerm_servicebus_subscription.service_bus_topic_subscriptions["${each.value["service_bus_name"]}_${each.value["topic_name"]}_${each.value["subscription_name"]}"].id
  filter_type     = "SqlFilter"
  sql_filter      = each.value["sql_filter"]
}

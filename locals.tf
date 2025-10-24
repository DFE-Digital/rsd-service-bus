locals {
  environment        = var.environment
  project_name       = var.project_name
  azure_location     = var.azure_location
  resource_prefix    = "${local.environment}${local.project_name}"
  service_bus_config = var.service_bus_config
  tags               = var.tags
}

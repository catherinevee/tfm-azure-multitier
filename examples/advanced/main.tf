# Advanced Multi-Tier Architecture Example
# This example demonstrates a comprehensive multi-tier architecture setup with all features

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location

  tags = var.common_tags
}

# Multi-Tier Architecture Module
module "multitier" {
  source = "../../"

  # Required variables
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  # Virtual Network Configuration
  virtual_network_name        = var.virtual_network_name
  virtual_network_address_space = var.virtual_network_address_space

  # Subnet Configuration
  web_subnet_address_prefixes      = var.web_subnet_address_prefixes
  app_subnet_address_prefixes      = var.app_subnet_address_prefixes
  database_subnet_address_prefixes = var.database_subnet_address_prefixes

  # Service Endpoints
  web_subnet_service_endpoints      = var.web_subnet_service_endpoints
  app_subnet_service_endpoints      = var.app_subnet_service_endpoints
  database_subnet_service_endpoints = var.database_subnet_service_endpoints

  # Network Security Group Configuration
  web_nsg_rules      = var.web_nsg_rules
  app_nsg_rules      = var.app_nsg_rules
  database_nsg_rules = var.database_nsg_rules

  # Load Balancer Configuration
  create_web_load_balancer = var.create_web_load_balancer
  create_app_load_balancer = var.create_app_load_balancer

  web_lb_probes = var.web_lb_probes
  web_lb_rules  = var.web_lb_rules
  app_lb_probes = var.app_lb_probes
  app_lb_rules  = var.app_lb_rules

  # Application Gateway Configuration
  create_application_gateway = var.create_application_gateway

  app_gateway_sku_name     = var.app_gateway_sku_name
  app_gateway_sku_tier     = var.app_gateway_sku_tier
  app_gateway_sku_capacity = var.app_gateway_sku_capacity

  app_gateway_backend_address_pools = var.app_gateway_backend_address_pools
  app_gateway_backend_http_settings = var.app_gateway_backend_http_settings
  app_gateway_http_listeners        = var.app_gateway_http_listeners
  app_gateway_request_routing_rules = var.app_gateway_request_routing_rules
  app_gateway_probes                = var.app_gateway_probes

  # Bastion Host Configuration
  create_bastion_host = var.create_bastion_host

  # Network Watcher Configuration
  create_network_watcher = var.create_network_watcher

  # Route Tables Configuration
  create_web_route_table      = var.create_web_route_table
  create_app_route_table      = var.create_app_route_table
  create_database_route_table = var.create_database_route_table

  web_route_table_rules      = var.web_route_table_routes
  app_route_table_routes     = var.app_route_table_routes
  database_route_table_routes = var.database_route_table_routes

  # DDoS Protection
  enable_ddos_protection = var.enable_ddos_protection

  # Common tags
  common_tags = var.common_tags
}

# Output the module results
output "module_outputs" {
  description = "All outputs from the multi-tier architecture module"
  value = module.multitier
}

# Specific outputs for easy access
output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = module.multitier.virtual_network_id
}

output "web_subnet_id" {
  description = "ID of the web tier subnet"
  value       = module.multitier.web_subnet_id
}

output "app_subnet_id" {
  description = "ID of the application tier subnet"
  value       = module.multitier.app_subnet_id
}

output "database_subnet_id" {
  description = "ID of the database tier subnet"
  value       = module.multitier.database_subnet_id
}

output "web_lb_id" {
  description = "ID of the web tier load balancer"
  value       = module.multitier.web_lb_id
}

output "app_lb_id" {
  description = "ID of the application tier load balancer"
  value       = module.multitier.app_lb_id
}

output "app_gateway_id" {
  description = "ID of the application gateway"
  value       = module.multitier.app_gateway_id
}

output "app_gateway_public_ip_address" {
  description = "Public IP address of the application gateway"
  value       = module.multitier.app_gateway_public_ip_address
}

output "bastion_host_id" {
  description = "ID of the bastion host"
  value       = module.multitier.bastion_host_id
}

output "bastion_host_public_ip_address" {
  description = "Public IP address of the bastion host"
  value       = module.multitier.bastion_host_public_ip_address
} 
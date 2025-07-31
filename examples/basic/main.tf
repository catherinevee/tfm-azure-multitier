# Basic Multi-Tier Architecture Example
# This example demonstrates a minimal multi-tier architecture setup

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

  # Load Balancer Configuration
  create_web_load_balancer = var.create_web_load_balancer
  create_app_load_balancer = var.create_app_load_balancer

  # Application Gateway Configuration
  create_application_gateway = var.create_application_gateway

  # Bastion Host Configuration
  create_bastion_host = var.create_bastion_host

  # Network Watcher Configuration
  create_network_watcher = var.create_network_watcher

  # Common tags
  common_tags = var.common_tags
}

# Output the module results
output "module_outputs" {
  description = "All outputs from the multi-tier architecture module"
  value = module.multitier
} 
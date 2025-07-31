# =============================================================================
# VIRTUAL NETWORK OUTPUTS
# =============================================================================

output "virtual_network_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "virtual_network_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "virtual_network_address_space" {
  description = "Address space of the virtual network"
  value       = azurerm_virtual_network.main.address_space
}

# =============================================================================
# SUBNET OUTPUTS
# =============================================================================

output "web_subnet_id" {
  description = "ID of the web tier subnet"
  value       = azurerm_subnet.web.id
}

output "web_subnet_name" {
  description = "Name of the web tier subnet"
  value       = azurerm_subnet.web.name
}

output "web_subnet_address_prefixes" {
  description = "Address prefixes of the web tier subnet"
  value       = azurerm_subnet.web.address_prefixes
}

output "app_subnet_id" {
  description = "ID of the application tier subnet"
  value       = azurerm_subnet.app.id
}

output "app_subnet_name" {
  description = "Name of the application tier subnet"
  value       = azurerm_subnet.app.name
}

output "app_subnet_address_prefixes" {
  description = "Address prefixes of the application tier subnet"
  value       = azurerm_subnet.app.address_prefixes
}

output "database_subnet_id" {
  description = "ID of the database tier subnet"
  value       = azurerm_subnet.database.id
}

output "database_subnet_name" {
  description = "Name of the database tier subnet"
  value       = azurerm_subnet.database.name
}

output "database_subnet_address_prefixes" {
  description = "Address prefixes of the database tier subnet"
  value       = azurerm_subnet.database.address_prefixes
}

output "app_gateway_subnet_id" {
  description = "ID of the application gateway subnet"
  value       = var.create_application_gateway ? azurerm_subnet.app_gateway[0].id : null
}

output "app_gateway_subnet_name" {
  description = "Name of the application gateway subnet"
  value       = var.create_application_gateway ? azurerm_subnet.app_gateway[0].name : null
}

output "app_gateway_subnet_address_prefixes" {
  description = "Address prefixes of the application gateway subnet"
  value       = var.create_application_gateway ? azurerm_subnet.app_gateway[0].address_prefixes : null
}

output "bastion_subnet_id" {
  description = "ID of the bastion host subnet"
  value       = var.create_bastion_host ? azurerm_subnet.bastion[0].id : null
}

output "bastion_subnet_name" {
  description = "Name of the bastion host subnet"
  value       = var.create_bastion_host ? azurerm_subnet.bastion[0].name : null
}

output "bastion_subnet_address_prefixes" {
  description = "Address prefixes of the bastion host subnet"
  value       = var.create_bastion_host ? azurerm_subnet.bastion[0].address_prefixes : null
}

# =============================================================================
# NETWORK SECURITY GROUP OUTPUTS
# =============================================================================

output "web_nsg_id" {
  description = "ID of the web tier network security group"
  value       = azurerm_network_security_group.web.id
}

output "web_nsg_name" {
  description = "Name of the web tier network security group"
  value       = azurerm_network_security_group.web.name
}

output "app_nsg_id" {
  description = "ID of the application tier network security group"
  value       = azurerm_network_security_group.app.id
}

output "app_nsg_name" {
  description = "Name of the application tier network security group"
  value       = azurerm_network_security_group.app.name
}

output "database_nsg_id" {
  description = "ID of the database tier network security group"
  value       = azurerm_network_security_group.database.id
}

output "database_nsg_name" {
  description = "Name of the database tier network security group"
  value       = azurerm_network_security_group.database.name
}

# =============================================================================
# ROUTE TABLE OUTPUTS
# =============================================================================

output "web_route_table_id" {
  description = "ID of the web tier route table"
  value       = var.create_web_route_table ? azurerm_route_table.web[0].id : null
}

output "web_route_table_name" {
  description = "Name of the web tier route table"
  value       = var.create_web_route_table ? azurerm_route_table.web[0].name : null
}

output "app_route_table_id" {
  description = "ID of the application tier route table"
  value       = var.create_app_route_table ? azurerm_route_table.app[0].id : null
}

output "app_route_table_name" {
  description = "Name of the application tier route table"
  value       = var.create_app_route_table ? azurerm_route_table.app[0].name : null
}

output "database_route_table_id" {
  description = "ID of the database tier route table"
  value       = var.create_database_route_table ? azurerm_route_table.database[0].id : null
}

output "database_route_table_name" {
  description = "Name of the database tier route table"
  value       = var.create_database_route_table ? azurerm_route_table.database[0].name : null
}

# =============================================================================
# LOAD BALANCER OUTPUTS
# =============================================================================

output "web_lb_id" {
  description = "ID of the web tier load balancer"
  value       = var.create_web_load_balancer ? azurerm_lb.web[0].id : null
}

output "web_lb_name" {
  description = "Name of the web tier load balancer"
  value       = var.create_web_load_balancer ? azurerm_lb.web[0].name : null
}

output "web_lb_frontend_ip_configuration" {
  description = "Frontend IP configuration of the web tier load balancer"
  value       = var.create_web_load_balancer ? azurerm_lb.web[0].frontend_ip_configuration : null
}

output "web_lb_backend_pool_id" {
  description = "ID of the web tier load balancer backend address pool"
  value       = var.create_web_load_balancer ? azurerm_lb_backend_address_pool.web[0].id : null
}

output "web_lb_backend_pool_name" {
  description = "Name of the web tier load balancer backend address pool"
  value       = var.create_web_load_balancer ? azurerm_lb_backend_address_pool.web[0].name : null
}

output "app_lb_id" {
  description = "ID of the application tier load balancer"
  value       = var.create_app_load_balancer ? azurerm_lb.app[0].id : null
}

output "app_lb_name" {
  description = "Name of the application tier load balancer"
  value       = var.create_app_load_balancer ? azurerm_lb.app[0].name : null
}

output "app_lb_frontend_ip_configuration" {
  description = "Frontend IP configuration of the application tier load balancer"
  value       = var.create_app_load_balancer ? azurerm_lb.app[0].frontend_ip_configuration : null
}

output "app_lb_backend_pool_id" {
  description = "ID of the application tier load balancer backend address pool"
  value       = var.create_app_load_balancer ? azurerm_lb_backend_address_pool.app[0].id : null
}

output "app_lb_backend_pool_name" {
  description = "Name of the application tier load balancer backend address pool"
  value       = var.create_app_load_balancer ? azurerm_lb_backend_address_pool.app[0].name : null
}

# =============================================================================
# APPLICATION GATEWAY OUTPUTS
# =============================================================================

output "app_gateway_id" {
  description = "ID of the application gateway"
  value       = var.create_application_gateway ? azurerm_application_gateway.main[0].id : null
}

output "app_gateway_name" {
  description = "Name of the application gateway"
  value       = var.create_application_gateway ? azurerm_application_gateway.main[0].name : null
}

output "app_gateway_public_ip_id" {
  description = "ID of the application gateway public IP"
  value       = var.create_application_gateway ? azurerm_public_ip.app_gateway[0].id : null
}

output "app_gateway_public_ip_address" {
  description = "Public IP address of the application gateway"
  value       = var.create_application_gateway ? azurerm_public_ip.app_gateway[0].ip_address : null
}

output "app_gateway_public_ip_fqdn" {
  description = "FQDN of the application gateway public IP"
  value       = var.create_application_gateway ? azurerm_public_ip.app_gateway[0].fqdn : null
}

output "app_gateway_backend_address_pools" {
  description = "Backend address pools of the application gateway"
  value       = var.create_application_gateway ? azurerm_application_gateway.main[0].backend_address_pool : null
}

output "app_gateway_backend_http_settings" {
  description = "Backend HTTP settings of the application gateway"
  value       = var.create_application_gateway ? azurerm_application_gateway.main[0].backend_http_settings : null
}

output "app_gateway_http_listeners" {
  description = "HTTP listeners of the application gateway"
  value       = var.create_application_gateway ? azurerm_application_gateway.main[0].http_listener : null
}

output "app_gateway_request_routing_rules" {
  description = "Request routing rules of the application gateway"
  value       = var.create_application_gateway ? azurerm_application_gateway.main[0].request_routing_rule : null
}

# =============================================================================
# BASTION HOST OUTPUTS
# =============================================================================

output "bastion_host_id" {
  description = "ID of the bastion host"
  value       = var.create_bastion_host ? azurerm_bastion_host.main[0].id : null
}

output "bastion_host_name" {
  description = "Name of the bastion host"
  value       = var.create_bastion_host ? azurerm_bastion_host.main[0].name : null
}

output "bastion_host_public_ip_id" {
  description = "ID of the bastion host public IP"
  value       = var.create_bastion_host ? azurerm_public_ip.bastion[0].id : null
}

output "bastion_host_public_ip_address" {
  description = "Public IP address of the bastion host"
  value       = var.create_bastion_host ? azurerm_public_ip.bastion[0].ip_address : null
}

output "bastion_host_public_ip_fqdn" {
  description = "FQDN of the bastion host public IP"
  value       = var.create_bastion_host ? azurerm_public_ip.bastion[0].fqdn : null
}

# =============================================================================
# NETWORK WATCHER OUTPUTS
# =============================================================================

output "network_watcher_id" {
  description = "ID of the network watcher"
  value       = var.create_network_watcher ? azurerm_network_watcher.main[0].id : null
}

output "network_watcher_name" {
  description = "Name of the network watcher"
  value       = var.create_network_watcher ? azurerm_network_watcher.main[0].name : null
}

# =============================================================================
# SUBNET AND NSG ASSOCIATION OUTPUTS
# =============================================================================

output "web_subnet_nsg_association_id" {
  description = "ID of the web subnet NSG association"
  value       = azurerm_subnet_network_security_group_association.web.id
}

output "app_subnet_nsg_association_id" {
  description = "ID of the application subnet NSG association"
  value       = azurerm_subnet_network_security_group_association.app.id
}

output "database_subnet_nsg_association_id" {
  description = "ID of the database subnet NSG association"
  value       = azurerm_subnet_network_security_group_association.database.id
}

# =============================================================================
# SUBNET AND ROUTE TABLE ASSOCIATION OUTPUTS
# =============================================================================

output "web_subnet_route_table_association_id" {
  description = "ID of the web subnet route table association"
  value       = var.create_web_route_table ? azurerm_subnet_route_table_association.web[0].id : null
}

output "app_subnet_route_table_association_id" {
  description = "ID of the application subnet route table association"
  value       = var.create_app_route_table ? azurerm_subnet_route_table_association.app[0].id : null
}

output "database_subnet_route_table_association_id" {
  description = "ID of the database subnet route table association"
  value       = var.create_database_route_table ? azurerm_subnet_route_table_association.database[0].id : null
}

# =============================================================================
# LOAD BALANCER PROBE OUTPUTS
# =============================================================================

output "web_lb_probes" {
  description = "Health probes of the web tier load balancer"
  value       = var.create_web_load_balancer ? azurerm_lb_probe.web : null
}

output "app_lb_probes" {
  description = "Health probes of the application tier load balancer"
  value       = var.create_app_load_balancer ? azurerm_lb_probe.app : null
}

# =============================================================================
# LOAD BALANCER RULE OUTPUTS
# =============================================================================

output "web_lb_rules" {
  description = "Load balancing rules of the web tier load balancer"
  value       = var.create_web_load_balancer ? azurerm_lb_rule.web : null
}

output "app_lb_rules" {
  description = "Load balancing rules of the application tier load balancer"
  value       = var.create_app_load_balancer ? azurerm_lb_rule.app : null
}

# =============================================================================
# MODULE SUMMARY OUTPUT
# =============================================================================

output "module_summary" {
  description = "Summary of the multi-tier architecture module deployment"
  value = {
    virtual_network = {
      id   = azurerm_virtual_network.main.id
      name = azurerm_virtual_network.main.name
    }
    subnets = {
      web      = azurerm_subnet.web.name
      app      = azurerm_subnet.app.name
      database = azurerm_subnet.database.name
      app_gateway = var.create_application_gateway ? azurerm_subnet.app_gateway[0].name : null
      bastion  = var.create_bastion_host ? azurerm_subnet.bastion[0].name : null
    }
    network_security_groups = {
      web      = azurerm_network_security_group.web.name
      app      = azurerm_network_security_group.app.name
      database = azurerm_network_security_group.database.name
    }
    load_balancers = {
      web = var.create_web_load_balancer ? azurerm_lb.web[0].name : null
      app = var.create_app_load_balancer ? azurerm_lb.app[0].name : null
    }
    application_gateway = var.create_application_gateway ? azurerm_application_gateway.main[0].name : null
    bastion_host       = var.create_bastion_host ? azurerm_bastion_host.main[0].name : null
    network_watcher    = var.create_network_watcher ? azurerm_network_watcher.main[0].name : null
  }
} 
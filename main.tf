# Azure Multi-Tier Architecture Terraform Module
# This module creates a comprehensive multi-tier architecture with web, application, and database tiers

# =============================================================================
# VIRTUAL NETWORKS
# =============================================================================

# Main Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.virtual_network_address_space

  dynamic "ddos_protection_plan" {
    for_each = var.enable_ddos_protection ? [1] : []
    content {
      id     = var.ddos_protection_plan_id
      enable = true
    }
  }

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "virtual-network"
    "Tier"      = "main"
  })

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      tags["LastModified"]
    ]
  }
}

# =============================================================================
# SUBNETS
# =============================================================================

# Web Tier Subnet
resource "azurerm_subnet" "web" {
  name                 = var.web_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.web_subnet_address_prefixes

  dynamic "delegation" {
    for_each = var.web_subnet_delegations
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.actions
      }
    }
  }

  dynamic "service_endpoints" {
    for_each = var.web_subnet_service_endpoints
    content {
      service = service_endpoints.value
    }
  }

  private_endpoint_network_policies_enabled = var.web_subnet_private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.web_subnet_private_link_service_network_policies_enabled
}

# Application Tier Subnet
resource "azurerm_subnet" "app" {
  name                 = var.app_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.app_subnet_address_prefixes

  dynamic "delegation" {
    for_each = var.app_subnet_delegations
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.actions
      }
    }
  }

  dynamic "service_endpoints" {
    for_each = var.app_subnet_service_endpoints
    content {
      service = service_endpoints.value
    }
  }

  private_endpoint_network_policies_enabled = var.app_subnet_private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.app_subnet_private_link_service_network_policies_enabled
}

# Database Tier Subnet
resource "azurerm_subnet" "database" {
  name                 = var.database_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.database_subnet_address_prefixes

  dynamic "delegation" {
    for_each = var.database_subnet_delegations
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.actions
      }
    }
  }

  dynamic "service_endpoints" {
    for_each = var.database_subnet_service_endpoints
    content {
      service = service_endpoints.value
    }
  }

  private_endpoint_network_policies_enabled = var.database_subnet_private_endpoint_network_policies_enabled
  private_link_service_network_policies_enabled = var.database_subnet_private_link_service_network_policies_enabled
}

# Application Gateway Subnet
resource "azurerm_subnet" "app_gateway" {
  count                = var.create_application_gateway ? 1 : 0
  name                 = var.app_gateway_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.app_gateway_subnet_address_prefixes
}

# Bastion Host Subnet (optional)
resource "azurerm_subnet" "bastion" {
  count                = var.create_bastion_host ? 1 : 0
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.bastion_subnet_address_prefixes
}

# =============================================================================
# NETWORK SECURITY GROUPS
# =============================================================================

# Web Tier NSG
resource "azurerm_network_security_group" "web" {
  name                = var.web_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.web_nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      description                = lookup(security_rule.value, "description", null)
    }
  }

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "network-security-group"
    "Tier"      = "web"
  })
}

# Application Tier NSG
resource "azurerm_network_security_group" "app" {
  name                = var.app_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.app_nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      description                = lookup(security_rule.value, "description", null)
    }
  }

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "network-security-group"
    "Tier"      = "application"
  })
}

# Database Tier NSG
resource "azurerm_network_security_group" "database" {
  name                = var.database_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.database_nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      description                = lookup(security_rule.value, "description", null)
    }
  }

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "network-security-group"
    "Tier"      = "database"
  })
}

# =============================================================================
# NSG ASSOCIATIONS
# =============================================================================

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.web.id
}

resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.app.id
}

resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = azurerm_subnet.database.id
  network_security_group_id = azurerm_network_security_group.database.id
}

# =============================================================================
# ROUTE TABLES
# =============================================================================

# Web Tier Route Table
resource "azurerm_route_table" "web" {
  count               = var.create_web_route_table ? 1 : 0
  name                = var.web_route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "route" {
    for_each = var.web_route_table_routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type         = route.value.next_hop_type
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address", null)
    }
  }

  disable_bgp_route_propagation = var.web_route_table_disable_bgp_route_propagation

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "route-table"
    "Tier"      = "web"
  })
}

# Application Tier Route Table
resource "azurerm_route_table" "app" {
  count               = var.create_app_route_table ? 1 : 0
  name                = var.app_route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "route" {
    for_each = var.app_route_table_routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type         = route.value.next_hop_type
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address", null)
    }
  }

  disable_bgp_route_propagation = var.app_route_table_disable_bgp_route_propagation

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "route-table"
    "Tier"      = "application"
  })
}

# Database Tier Route Table
resource "azurerm_route_table" "database" {
  count               = var.create_database_route_table ? 1 : 0
  name                = var.database_route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "route" {
    for_each = var.database_route_table_routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type         = route.value.next_hop_type
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address", null)
    }
  }

  disable_bgp_route_propagation = var.database_route_table_disable_bgp_route_propagation

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "route-table"
    "Tier"      = "database"
  })
}

# =============================================================================
# ROUTE TABLE ASSOCIATIONS
# =============================================================================

resource "azurerm_subnet_route_table_association" "web" {
  count          = var.create_web_route_table ? 1 : 0
  subnet_id      = azurerm_subnet.web.id
  route_table_id = azurerm_route_table.web[0].id
}

resource "azurerm_subnet_route_table_association" "app" {
  count          = var.create_app_route_table ? 1 : 0
  subnet_id      = azurerm_subnet.app.id
  route_table_id = azurerm_route_table.app[0].id
}

resource "azurerm_subnet_route_table_association" "database" {
  count          = var.create_database_route_table ? 1 : 0
  subnet_id      = azurerm_subnet.database.id
  route_table_id = azurerm_route_table.database[0].id
}

# =============================================================================
# LOAD BALANCERS
# =============================================================================

# Web Tier Load Balancer
resource "azurerm_lb" "web" {
  count               = var.create_web_load_balancer ? 1 : 0
  name                = var.web_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.web_lb_sku
  sku_tier            = var.web_lb_sku_tier

  frontend_ip_configuration {
    name                          = var.web_lb_frontend_ip_configuration_name
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address            = var.web_lb_private_ip_address
    private_ip_address_allocation = var.web_lb_private_ip_address_allocation
    private_ip_address_version    = var.web_lb_private_ip_address_version
  }

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "load-balancer"
    "Tier"      = "web"
  })
}

# Application Tier Load Balancer
resource "azurerm_lb" "app" {
  count               = var.create_app_load_balancer ? 1 : 0
  name                = var.app_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.app_lb_sku
  sku_tier            = var.app_lb_sku_tier

  frontend_ip_configuration {
    name                          = var.app_lb_frontend_ip_configuration_name
    subnet_id                     = azurerm_subnet.app.id
    private_ip_address            = var.app_lb_private_ip_address
    private_ip_address_allocation = var.app_lb_private_ip_address_allocation
    private_ip_address_version    = var.app_lb_private_ip_address_version
  }

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "load-balancer"
    "Tier"      = "application"
  })
}

# =============================================================================
# LOAD BALANCER BACKEND ADDRESS POOLS
# =============================================================================

resource "azurerm_lb_backend_address_pool" "web" {
  count           = var.create_web_load_balancer ? 1 : 0
  name            = var.web_lb_backend_pool_name
  loadbalancer_id = azurerm_lb.web[0].id
}

resource "azurerm_lb_backend_address_pool" "app" {
  count           = var.create_app_load_balancer ? 1 : 0
  name            = var.app_lb_backend_pool_name
  loadbalancer_id = azurerm_lb.app[0].id
}

# =============================================================================
# LOAD BALANCER PROBES
# =============================================================================

resource "azurerm_lb_probe" "web" {
  for_each        = var.create_web_load_balancer ? var.web_lb_probes : {}
  name            = each.value.name
  loadbalancer_id = azurerm_lb.web[0].id
  port            = each.value.port
  protocol        = each.value.protocol
  request_path    = lookup(each.value, "request_path", null)
  interval_in_seconds = lookup(each.value, "interval_in_seconds", 15)
  number_of_probes   = lookup(each.value, "number_of_probes", 2)
}

resource "azurerm_lb_probe" "app" {
  for_each        = var.create_app_load_balancer ? var.app_lb_probes : {}
  name            = each.value.name
  loadbalancer_id = azurerm_lb.app[0].id
  port            = each.value.port
  protocol        = each.value.protocol
  request_path    = lookup(each.value, "request_path", null)
  interval_in_seconds = lookup(each.value, "interval_in_seconds", 15)
  number_of_probes   = lookup(each.value, "number_of_probes", 2)
}

# =============================================================================
# LOAD BALANCER RULES
# =============================================================================

resource "azurerm_lb_rule" "web" {
  for_each                       = var.create_web_load_balancer ? var.web_lb_rules : {}
  name                           = each.value.name
  loadbalancer_id                = azurerm_lb.web[0].id
  frontend_ip_configuration_name = var.web_lb_frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web[0].id]
  probe_id                       = azurerm_lb_probe.web[each.value.probe_name].id
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  load_distribution              = lookup(each.value, "load_distribution", "Default")
  enable_floating_ip             = lookup(each.value, "enable_floating_ip", false)
  idle_timeout_in_minutes        = lookup(each.value, "idle_timeout_in_minutes", 4)
  enable_tcp_reset               = lookup(each.value, "enable_tcp_reset", false)
}

resource "azurerm_lb_rule" "app" {
  for_each                       = var.create_app_load_balancer ? var.app_lb_rules : {}
  name                           = each.value.name
  loadbalancer_id                = azurerm_lb.app[0].id
  frontend_ip_configuration_name = var.app_lb_frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.app[0].id]
  probe_id                       = azurerm_lb_probe.app[each.value.probe_name].id
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  load_distribution              = lookup(each.value, "load_distribution", "Default")
  enable_floating_ip             = lookup(each.value, "enable_floating_ip", false)
  idle_timeout_in_minutes        = lookup(each.value, "idle_timeout_in_minutes", 4)
  enable_tcp_reset               = lookup(each.value, "enable_tcp_reset", false)
}

# =============================================================================
# APPLICATION GATEWAY
# =============================================================================

# Public IP for Application Gateway
resource "azurerm_public_ip" "app_gateway" {
  count               = var.create_application_gateway ? 1 : 0
  name                = var.app_gateway_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.app_gateway_public_ip_allocation_method
  sku                 = var.app_gateway_public_ip_sku
  domain_name_label   = var.app_gateway_public_ip_domain_name_label

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "public-ip"
    "Tier"      = "application-gateway"
  })
}

# Application Gateway
resource "azurerm_application_gateway" "main" {
  count               = var.create_application_gateway ? 1 : 0
  name                = var.app_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = var.app_gateway_sku_name
    tier     = var.app_gateway_sku_tier
    capacity = var.app_gateway_sku_capacity
  }

  gateway_ip_configuration {
    name      = var.app_gateway_ip_configuration_name
    subnet_id = azurerm_subnet.app_gateway[0].id
  }

  frontend_port {
    name = var.app_gateway_frontend_port_name
    port = var.app_gateway_frontend_port
  }

  frontend_ip_configuration {
    name                 = var.app_gateway_frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.app_gateway[0].id
  }

  dynamic "backend_address_pool" {
    for_each = var.app_gateway_backend_address_pools
    content {
      name         = backend_address_pool.value.name
      fqdn_list    = lookup(backend_address_pool.value, "fqdn_list", null)
      ip_addresses = lookup(backend_address_pool.value, "ip_addresses", null)
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.app_gateway_backend_http_settings
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = lookup(backend_http_settings.value, "request_timeout", 20)
      probe_name            = lookup(backend_http_settings.value, "probe_name", null)
    }
  }

  dynamic "http_listener" {
    for_each = var.app_gateway_http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = var.app_gateway_frontend_ip_configuration_name
      frontend_port_name             = var.app_gateway_frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = lookup(http_listener.value, "host_name", null)
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.app_gateway_request_routing_rules
    content {
      name                       = request_routing_rule.value.name
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = lookup(request_routing_rule.value, "backend_address_pool_name", null)
      backend_http_settings_name = lookup(request_routing_rule.value, "backend_http_settings_name", null)
      url_path_map_name          = lookup(request_routing_rule.value, "url_path_map_name", null)
      redirect_configuration_name = lookup(request_routing_rule.value, "redirect_configuration_name", null)
    }
  }

  dynamic "probe" {
    for_each = var.app_gateway_probes
    content {
      name                = probe.value.name
      protocol            = probe.value.protocol
      host                = lookup(probe.value, "host", "127.0.0.1")
      path                = probe.value.path
      interval            = lookup(probe.value, "interval", 30)
      timeout             = lookup(probe.value, "timeout", 30)
      unhealthy_threshold = lookup(probe.value, "unhealthy_threshold", 3)
      match {
        status_code = probe.value.match_status_codes
      }
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.app_gateway_ssl_certificates
    content {
      name     = ssl_certificate.value.name
      data     = ssl_certificate.value.data
      password = ssl_certificate.value.password
    }
  }

  dynamic "authentication_certificate" {
    for_each = var.app_gateway_authentication_certificates
    content {
      name = authentication_certificate.value.name
      data = authentication_certificate.value.data
    }
  }

  dynamic "url_path_map" {
    for_each = var.app_gateway_url_path_maps
    content {
      name                               = url_path_map.value.name
      default_backend_address_pool_name  = lookup(url_path_map.value, "default_backend_address_pool_name", null)
      default_backend_http_settings_name = lookup(url_path_map.value, "default_backend_http_settings_name", null)
      default_redirect_configuration_name = lookup(url_path_map.value, "default_redirect_configuration_name", null)

      dynamic "path_rule" {
        for_each = url_path_map.value.path_rules
        content {
          name                        = path_rule.value.name
          paths                       = path_rule.value.paths
          backend_address_pool_name   = lookup(path_rule.value, "backend_address_pool_name", null)
          backend_http_settings_name  = lookup(path_rule.value, "backend_http_settings_name", null)
          redirect_configuration_name = lookup(path_rule.value, "redirect_configuration_name", null)
        }
      }
    }
  }

  dynamic "redirect_configuration" {
    for_each = var.app_gateway_redirect_configurations
    content {
      name                 = redirect_configuration.value.name
      redirect_type        = redirect_configuration.value.redirect_type
      target_listener_name = lookup(redirect_configuration.value, "target_listener_name", null)
      target_url           = lookup(redirect_configuration.value, "target_url", null)
      include_path         = lookup(redirect_configuration.value, "include_path", false)
      include_query_string = lookup(redirect_configuration.value, "include_query_string", false)
    }
  }

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "application-gateway"
  })
}

# =============================================================================
# BASTION HOST
# =============================================================================

# Public IP for Bastion Host
resource "azurerm_public_ip" "bastion" {
  count               = var.create_bastion_host ? 1 : 0
  name                = var.bastion_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.bastion_public_ip_allocation_method
  sku                 = var.bastion_public_ip_sku

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "public-ip"
    "Tier"      = "bastion"
  })
}

# Bastion Host
resource "azurerm_bastion_host" "main" {
  count               = var.create_bastion_host ? 1 : 0
  name                = var.bastion_host_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = var.bastion_ip_configuration_name
    subnet_id            = azurerm_subnet.bastion[0].id
    public_ip_address_id = azurerm_public_ip.bastion[0].id
  }

  sku = var.bastion_sku

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "bastion-host"
  })
}

# =============================================================================
# NETWORK WATCHER
# =============================================================================

# Network Watcher (required for some networking features)
resource "azurerm_network_watcher" "main" {
  count               = var.create_network_watcher ? 1 : 0
  name                = var.network_watcher_name != null ? var.network_watcher_name : "NetworkWatcher_${var.location}"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(var.common_tags, {
    "Module"    = "azure-multitier"
    "Component" = "network-watcher"
  })
} 
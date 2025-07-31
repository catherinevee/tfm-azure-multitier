# Variables for Advanced Multi-Tier Architecture Example

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-multitier-advanced"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-multitier-advanced"
}

variable "virtual_network_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["172.16.0.0/16"]
}

variable "web_subnet_address_prefixes" {
  description = "Address prefixes for the web tier subnet"
  type        = list(string)
  default     = ["172.16.1.0/24"]
}

variable "app_subnet_address_prefixes" {
  description = "Address prefixes for the application tier subnet"
  type        = list(string)
  default     = ["172.16.2.0/24"]
}

variable "database_subnet_address_prefixes" {
  description = "Address prefixes for the database tier subnet"
  type        = list(string)
  default     = ["172.16.3.0/24"]
}

variable "web_subnet_service_endpoints" {
  description = "Service endpoints for the web tier subnet"
  type        = list(string)
  default     = ["Microsoft.Storage", "Microsoft.KeyVault"]
}

variable "app_subnet_service_endpoints" {
  description = "Service endpoints for the application tier subnet"
  type        = list(string)
  default     = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus"]
}

variable "database_subnet_service_endpoints" {
  description = "Service endpoints for the database tier subnet"
  type        = list(string)
  default     = ["Microsoft.Sql", "Microsoft.KeyVault"]
}

variable "web_nsg_rules" {
  description = "Security rules for the web tier network security group"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = optional(string)
  }))
  default = [
    {
      name                       = "AllowHTTP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow HTTP traffic"
    },
    {
      name                       = "AllowHTTPS"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "Allow HTTPS traffic"
    },
    {
      name                       = "AllowSSH"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "172.16.5.0/24"
      destination_address_prefix = "*"
      description                = "Allow SSH from bastion subnet"
    }
  ]
}

variable "app_nsg_rules" {
  description = "Security rules for the application tier network security group"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = optional(string)
  }))
  default = [
    {
      name                       = "AllowWebToApp"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "172.16.1.0/24"
      destination_address_prefix = "*"
      description                = "Allow traffic from web tier to application tier"
    },
    {
      name                       = "AllowAppToApp"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "172.16.2.0/24"
      destination_address_prefix = "*"
      description                = "Allow internal application communication"
    },
    {
      name                       = "AllowSSH"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "172.16.5.0/24"
      destination_address_prefix = "*"
      description                = "Allow SSH from bastion subnet"
    }
  ]
}

variable "database_nsg_rules" {
  description = "Security rules for the database tier network security group"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = optional(string)
  }))
  default = [
    {
      name                       = "AllowAppToDatabase"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "172.16.2.0/24"
      destination_address_prefix = "*"
      description                = "Allow traffic from application tier to database tier"
    },
    {
      name                       = "AllowDatabaseAdmin"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "172.16.5.0/24"
      destination_address_prefix = "*"
      description                = "Allow database access from bastion subnet"
    }
  ]
}

variable "create_web_load_balancer" {
  description = "Whether to create a load balancer for the web tier"
  type        = bool
  default     = true
}

variable "create_app_load_balancer" {
  description = "Whether to create a load balancer for the application tier"
  type        = bool
  default     = true
}

variable "web_lb_probes" {
  description = "Health probes for the web tier load balancer"
  type = map(object({
    name                = string
    port                = number
    protocol            = string
    request_path        = optional(string)
    interval_in_seconds = optional(number)
    number_of_probes    = optional(number)
  }))
  default = {
    "web-http-probe" = {
      name                = "web-http-probe"
      port                = 80
      protocol            = "Http"
      request_path        = "/"
      interval_in_seconds = 15
      number_of_probes    = 2
    },
    "web-https-probe" = {
      name                = "web-https-probe"
      port                = 443
      protocol            = "Http"
      request_path        = "/"
      interval_in_seconds = 15
      number_of_probes    = 2
    }
  }
}

variable "web_lb_rules" {
  description = "Load balancing rules for the web tier load balancer"
  type = map(object({
    name                    = string
    probe_name              = string
    protocol                = string
    frontend_port           = number
    backend_port            = number
    load_distribution       = optional(string)
    enable_floating_ip      = optional(bool)
    idle_timeout_in_minutes = optional(number)
    enable_tcp_reset        = optional(bool)
  }))
  default = {
    "web-http-rule" = {
      name                    = "web-http-rule"
      probe_name              = "web-http-probe"
      protocol                = "Tcp"
      frontend_port           = 80
      backend_port            = 80
      load_distribution       = "Default"
      enable_floating_ip      = false
      idle_timeout_in_minutes = 4
      enable_tcp_reset        = false
    },
    "web-https-rule" = {
      name                    = "web-https-rule"
      probe_name              = "web-https-probe"
      protocol                = "Tcp"
      frontend_port           = 443
      backend_port            = 443
      load_distribution       = "Default"
      enable_floating_ip      = false
      idle_timeout_in_minutes = 4
      enable_tcp_reset        = false
    }
  }
}

variable "app_lb_probes" {
  description = "Health probes for the application tier load balancer"
  type = map(object({
    name                = string
    port                = number
    protocol            = string
    request_path        = optional(string)
    interval_in_seconds = optional(number)
    number_of_probes    = optional(number)
  }))
  default = {
    "app-http-probe" = {
      name                = "app-http-probe"
      port                = 8080
      protocol            = "Http"
      request_path        = "/health"
      interval_in_seconds = 15
      number_of_probes    = 2
    }
  }
}

variable "app_lb_rules" {
  description = "Load balancing rules for the application tier load balancer"
  type = map(object({
    name                    = string
    probe_name              = string
    protocol                = string
    frontend_port           = number
    backend_port            = number
    load_distribution       = optional(string)
    enable_floating_ip      = optional(bool)
    idle_timeout_in_minutes = optional(number)
    enable_tcp_reset        = optional(bool)
  }))
  default = {
    "app-http-rule" = {
      name                    = "app-http-rule"
      probe_name              = "app-http-probe"
      protocol                = "Tcp"
      frontend_port           = 8080
      backend_port            = 8080
      load_distribution       = "Default"
      enable_floating_ip      = false
      idle_timeout_in_minutes = 4
      enable_tcp_reset        = false
    }
  }
}

variable "create_application_gateway" {
  description = "Whether to create an application gateway"
  type        = bool
  default     = true
}

variable "app_gateway_sku_name" {
  description = "SKU name of the application gateway"
  type        = string
  default     = "WAF_v2"
}

variable "app_gateway_sku_tier" {
  description = "SKU tier of the application gateway"
  type        = string
  default     = "WAF_v2"
}

variable "app_gateway_sku_capacity" {
  description = "SKU capacity of the application gateway"
  type        = number
  default     = 2
}

variable "app_gateway_backend_address_pools" {
  description = "Backend address pools for the application gateway"
  type = list(object({
    name         = string
    fqdn_list    = optional(list(string))
    ip_addresses = optional(list(string))
  }))
  default = [
    {
      name = "web-backend-pool"
      ip_addresses = ["172.16.1.10", "172.16.1.11"]
    }
  ]
}

variable "app_gateway_backend_http_settings" {
  description = "Backend HTTP settings for the application gateway"
  type = list(object({
    name                  = string
    cookie_based_affinity = string
    port                  = number
    protocol              = string
    request_timeout       = optional(number)
    probe_name            = optional(string)
  }))
  default = [
    {
      name                  = "web-http-settings"
      cookie_based_affinity = "Enabled"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 30
    }
  ]
}

variable "app_gateway_http_listeners" {
  description = "HTTP listeners for the application gateway"
  type = list(object({
    name                 = string
    protocol             = string
    host_name            = optional(string)
    ssl_certificate_name = optional(string)
  }))
  default = [
    {
      name     = "web-listener"
      protocol = "Http"
    }
  ]
}

variable "app_gateway_request_routing_rules" {
  description = "Request routing rules for the application gateway"
  type = list(object({
    name                        = string
    rule_type                   = string
    http_listener_name          = string
    backend_address_pool_name   = optional(string)
    backend_http_settings_name  = optional(string)
    url_path_map_name           = optional(string)
    redirect_configuration_name = optional(string)
  }))
  default = [
    {
      name                       = "web-routing-rule"
      rule_type                  = "Basic"
      http_listener_name         = "web-listener"
      backend_address_pool_name  = "web-backend-pool"
      backend_http_settings_name = "web-http-settings"
    }
  ]
}

variable "app_gateway_probes" {
  description = "Health probes for the application gateway"
  type = list(object({
    name                = string
    protocol            = string
    path                = string
    host                = optional(string)
    interval            = optional(number)
    timeout             = optional(number)
    unhealthy_threshold = optional(number)
    match_status_codes  = list(string)
  }))
  default = [
    {
      name                = "web-probe"
      protocol            = "Http"
      path                = "/"
      host                = "127.0.0.1"
      interval            = 30
      timeout             = 30
      unhealthy_threshold = 3
      match_status_codes  = ["200-399"]
    }
  ]
}

variable "create_bastion_host" {
  description = "Whether to create a bastion host"
  type        = bool
  default     = true
}

variable "create_network_watcher" {
  description = "Whether to create a network watcher"
  type        = bool
  default     = true
}

variable "create_web_route_table" {
  description = "Whether to create a route table for the web tier"
  type        = bool
  default     = false
}

variable "create_app_route_table" {
  description = "Whether to create a route table for the application tier"
  type        = bool
  default     = false
}

variable "create_database_route_table" {
  description = "Whether to create a route table for the database tier"
  type        = bool
  default     = false
}

variable "web_route_table_routes" {
  description = "Routes for the web tier route table"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type         = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "app_route_table_routes" {
  description = "Routes for the application tier route table"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type         = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "database_route_table_routes" {
  description = "Routes for the database tier route table"
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type         = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "enable_ddos_protection" {
  description = "Whether to enable DDoS protection on the virtual network"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "multitier-advanced"
    ManagedBy   = "terraform"
    Owner       = "devops-team"
    CostCenter  = "IT-001"
  }
} 
# =============================================================================
# REQUIRED VARIABLES
# =============================================================================

variable "resource_group_name" {
  description = "Name of the resource group where resources will be created"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.resource_group_name))
    error_message = "Resource group name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9]+$", var.location))
    error_message = "Location must be a valid Azure region name."
  }
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-multitier"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.virtual_network_name))
    error_message = "Virtual network name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "virtual_network_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]

  validation {
    condition = alltrue([
      for cidr in var.virtual_network_address_space : can(cidrhost(cidr, 0))
    ])
    error_message = "All address spaces must be valid CIDR blocks."
  }
}

# =============================================================================
# SUBNET VARIABLES
# =============================================================================

variable "web_subnet_name" {
  description = "Name of the web tier subnet"
  type        = string
  default     = "snet-web"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.web_subnet_name))
    error_message = "Web subnet name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "web_subnet_address_prefixes" {
  description = "Address prefixes for the web tier subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]

  validation {
    condition = alltrue([
      for cidr in var.web_subnet_address_prefixes : can(cidrhost(cidr, 0))
    ])
    error_message = "All web subnet address prefixes must be valid CIDR blocks."
  }
}

variable "web_subnet_delegations" {
  description = "Service delegations for the web tier subnet"
  type = list(object({
    name = string
    service_name = string
    actions = list(string)
  }))
  default = []
}

variable "web_subnet_service_endpoints" {
  description = "Service endpoints for the web tier subnet"
  type        = list(string)
  default     = []
}

variable "web_subnet_private_endpoint_network_policies_enabled" {
  description = "Enable or disable private endpoint network policies on the web tier subnet"
  type        = bool
  default     = false
}

variable "web_subnet_private_link_service_network_policies_enabled" {
  description = "Enable or disable private link service network policies on the web tier subnet"
  type        = bool
  default     = false
}

variable "app_subnet_name" {
  description = "Name of the application tier subnet"
  type        = string
  default     = "snet-app"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.app_subnet_name))
    error_message = "Application subnet name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "app_subnet_address_prefixes" {
  description = "Address prefixes for the application tier subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]

  validation {
    condition = alltrue([
      for cidr in var.app_subnet_address_prefixes : can(cidrhost(cidr, 0))
    ])
    error_message = "All application subnet address prefixes must be valid CIDR blocks."
  }
}

variable "app_subnet_delegations" {
  description = "Service delegations for the application tier subnet"
  type = list(object({
    name = string
    service_name = string
    actions = list(string)
  }))
  default = []
}

variable "app_subnet_service_endpoints" {
  description = "Service endpoints for the application tier subnet"
  type        = list(string)
  default     = []
}

variable "app_subnet_private_endpoint_network_policies_enabled" {
  description = "Enable or disable private endpoint network policies on the application tier subnet"
  type        = bool
  default     = false
}

variable "app_subnet_private_link_service_network_policies_enabled" {
  description = "Enable or disable private link service network policies on the application tier subnet"
  type        = bool
  default     = false
}

variable "database_subnet_name" {
  description = "Name of the database tier subnet"
  type        = string
  default     = "snet-database"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.database_subnet_name))
    error_message = "Database subnet name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "database_subnet_address_prefixes" {
  description = "Address prefixes for the database tier subnet"
  type        = list(string)
  default     = ["10.0.3.0/24"]

  validation {
    condition = alltrue([
      for cidr in var.database_subnet_address_prefixes : can(cidrhost(cidr, 0))
    ])
    error_message = "All database subnet address prefixes must be valid CIDR blocks."
  }
}

variable "database_subnet_delegations" {
  description = "Service delegations for the database tier subnet"
  type = list(object({
    name = string
    service_name = string
    actions = list(string)
  }))
  default = []
}

variable "database_subnet_service_endpoints" {
  description = "Service endpoints for the database tier subnet"
  type        = list(string)
  default     = []
}

variable "database_subnet_private_endpoint_network_policies_enabled" {
  description = "Enable or disable private endpoint network policies on the database tier subnet"
  type        = bool
  default     = false
}

variable "database_subnet_private_link_service_network_policies_enabled" {
  description = "Enable or disable private link service network policies on the database tier subnet"
  type        = bool
  default     = false
}

variable "app_gateway_subnet_name" {
  description = "Name of the application gateway subnet"
  type        = string
  default     = "snet-appgateway"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.app_gateway_subnet_name))
    error_message = "Application gateway subnet name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "app_gateway_subnet_address_prefixes" {
  description = "Address prefixes for the application gateway subnet"
  type        = list(string)
  default     = ["10.0.4.0/24"]

  validation {
    condition = alltrue([
      for cidr in var.app_gateway_subnet_address_prefixes : can(cidrhost(cidr, 0))
    ])
    error_message = "All application gateway subnet address prefixes must be valid CIDR blocks."
  }
}

variable "bastion_subnet_name" {
  description = "Name of the bastion host subnet"
  type        = string
  default     = "snet-bastion"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.bastion_subnet_name))
    error_message = "Bastion subnet name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "bastion_subnet_address_prefixes" {
  description = "Address prefixes for the bastion host subnet"
  type        = list(string)
  default     = ["10.0.5.0/24"]

  validation {
    condition = alltrue([
      for cidr in var.bastion_subnet_address_prefixes : can(cidrhost(cidr, 0))
    ])
    error_message = "All bastion subnet address prefixes must be valid CIDR blocks."
  }
}

# =============================================================================
# NETWORK SECURITY GROUP VARIABLES
# =============================================================================

variable "web_nsg_name" {
  description = "Name of the web tier network security group"
  type        = string
  default     = "nsg-web"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.web_nsg_name))
    error_message = "Web NSG name must contain only alphanumeric characters, hyphens, and underscores."
  }
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
    }
  ]

  validation {
    condition = alltrue([
      for rule in var.web_nsg_rules : contains(["Inbound", "Outbound"], rule.direction)
    ])
    error_message = "NSG rule direction must be either 'Inbound' or 'Outbound'."
  }

  validation {
    condition = alltrue([
      for rule in var.web_nsg_rules : contains(["Allow", "Deny"], rule.access)
    ])
    error_message = "NSG rule access must be either 'Allow' or 'Deny'."
  }

  validation {
    condition = alltrue([
      for rule in var.web_nsg_rules : contains(["Tcp", "Udp", "Icmp", "Esp", "Ah", "*"], rule.protocol)
    ])
    error_message = "NSG rule protocol must be one of: Tcp, Udp, Icmp, Esp, Ah, *."
  }
}

variable "app_nsg_name" {
  description = "Name of the application tier network security group"
  type        = string
  default     = "nsg-app"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.app_nsg_name))
    error_message = "Application NSG name must contain only alphanumeric characters, hyphens, and underscores."
  }
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
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
      description                = "Allow traffic from web tier to application tier"
    }
  ]

  validation {
    condition = alltrue([
      for rule in var.app_nsg_rules : contains(["Inbound", "Outbound"], rule.direction)
    ])
    error_message = "NSG rule direction must be either 'Inbound' or 'Outbound'."
  }

  validation {
    condition = alltrue([
      for rule in var.app_nsg_rules : contains(["Allow", "Deny"], rule.access)
    ])
    error_message = "NSG rule access must be either 'Allow' or 'Deny'."
  }

  validation {
    condition = alltrue([
      for rule in var.app_nsg_rules : contains(["Tcp", "Udp", "Icmp", "Esp", "Ah", "*"], rule.protocol)
    ])
    error_message = "NSG rule protocol must be one of: Tcp, Udp, Icmp, Esp, Ah, *."
  }
}

variable "database_nsg_name" {
  description = "Name of the database tier network security group"
  type        = string
  default     = "nsg-database"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.database_nsg_name))
    error_message = "Database NSG name must contain only alphanumeric characters, hyphens, and underscores."
  }
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
      source_address_prefix      = "10.0.2.0/24"
      destination_address_prefix = "*"
      description                = "Allow traffic from application tier to database tier"
    }
  ]

  validation {
    condition = alltrue([
      for rule in var.database_nsg_rules : contains(["Inbound", "Outbound"], rule.direction)
    ])
    error_message = "NSG rule direction must be either 'Inbound' or 'Outbound'."
  }

  validation {
    condition = alltrue([
      for rule in var.database_nsg_rules : contains(["Allow", "Deny"], rule.access)
    ])
    error_message = "NSG rule access must be either 'Allow' or 'Deny'."
  }

  validation {
    condition = alltrue([
      for rule in var.database_nsg_rules : contains(["Tcp", "Udp", "Icmp", "Esp", "Ah", "*"], rule.protocol)
    ])
    error_message = "NSG rule protocol must be one of: Tcp, Udp, Icmp, Esp, Ah, *."
  }
}

# =============================================================================
# ROUTE TABLE VARIABLES
# =============================================================================

variable "create_web_route_table" {
  description = "Whether to create a route table for the web tier"
  type        = bool
  default     = false
}

variable "web_route_table_name" {
  description = "Name of the web tier route table"
  type        = string
  default     = "rt-web"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.web_route_table_name))
    error_message = "Web route table name must contain only alphanumeric characters, hyphens, and underscores."
  }
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

variable "web_route_table_disable_bgp_route_propagation" {
  description = "Disable BGP route propagation for the web tier route table"
  type        = bool
  default     = false
}

variable "create_app_route_table" {
  description = "Whether to create a route table for the application tier"
  type        = bool
  default     = false
}

variable "app_route_table_name" {
  description = "Name of the application tier route table"
  type        = string
  default     = "rt-app"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.app_route_table_name))
    error_message = "Application route table name must contain only alphanumeric characters, hyphens, and underscores."
  }
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

variable "app_route_table_disable_bgp_route_propagation" {
  description = "Disable BGP route propagation for the application tier route table"
  type        = bool
  default     = false
}

variable "create_database_route_table" {
  description = "Whether to create a route table for the database tier"
  type        = bool
  default     = false
}

variable "database_route_table_name" {
  description = "Name of the database tier route table"
  type        = string
  default     = "rt-database"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.database_route_table_name))
    error_message = "Database route table name must contain only alphanumeric characters, hyphens, and underscores."
  }
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

variable "database_route_table_disable_bgp_route_propagation" {
  description = "Disable BGP route propagation for the database tier route table"
  type        = bool
  default     = false
}

# =============================================================================
# LOAD BALANCER VARIABLES
# =============================================================================

variable "create_web_load_balancer" {
  description = "Whether to create a load balancer for the web tier"
  type        = bool
  default     = false
}

variable "web_lb_name" {
  description = "Name of the web tier load balancer"
  type        = string
  default     = "lb-web"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.web_lb_name))
    error_message = "Web load balancer name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "web_lb_sku" {
  description = "SKU of the web tier load balancer"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.web_lb_sku)
    error_message = "Web load balancer SKU must be either 'Basic' or 'Standard'."
  }
}

variable "web_lb_sku_tier" {
  description = "SKU tier of the web tier load balancer"
  type        = string
  default     = "Regional"

  validation {
    condition     = contains(["Global", "Regional"], var.web_lb_sku_tier)
    error_message = "Web load balancer SKU tier must be either 'Global' or 'Regional'."
  }
}

variable "web_lb_frontend_ip_configuration_name" {
  description = "Name of the web tier load balancer frontend IP configuration"
  type        = string
  default     = "web-lb-frontend-ip"
}

variable "web_lb_private_ip_address" {
  description = "Private IP address for the web tier load balancer frontend"
  type        = string
  default     = null
}

variable "web_lb_private_ip_address_allocation" {
  description = "Private IP address allocation method for the web tier load balancer"
  type        = string
  default     = "Dynamic"

  validation {
    condition     = contains(["Static", "Dynamic"], var.web_lb_private_ip_address_allocation)
    error_message = "Web load balancer private IP address allocation must be either 'Static' or 'Dynamic'."
  }
}

variable "web_lb_private_ip_address_version" {
  description = "Private IP address version for the web tier load balancer"
  type        = string
  default     = "IPv4"

  validation {
    condition     = contains(["IPv4", "IPv6"], var.web_lb_private_ip_address_version)
    error_message = "Web load balancer private IP address version must be either 'IPv4' or 'IPv6'."
  }
}

variable "web_lb_backend_pool_name" {
  description = "Name of the web tier load balancer backend address pool"
  type        = string
  default     = "web-lb-backend-pool"
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
    }
  }
}

variable "create_app_load_balancer" {
  description = "Whether to create a load balancer for the application tier"
  type        = bool
  default     = false
}

variable "app_lb_name" {
  description = "Name of the application tier load balancer"
  type        = string
  default     = "lb-app"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.app_lb_name))
    error_message = "Application load balancer name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "app_lb_sku" {
  description = "SKU of the application tier load balancer"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.app_lb_sku)
    error_message = "Application load balancer SKU must be either 'Basic' or 'Standard'."
  }
}

variable "app_lb_sku_tier" {
  description = "SKU tier of the application tier load balancer"
  type        = string
  default     = "Regional"

  validation {
    condition     = contains(["Global", "Regional"], var.app_lb_sku_tier)
    error_message = "Application load balancer SKU tier must be either 'Global' or 'Regional'."
  }
}

variable "app_lb_frontend_ip_configuration_name" {
  description = "Name of the application tier load balancer frontend IP configuration"
  type        = string
  default     = "app-lb-frontend-ip"
}

variable "app_lb_private_ip_address" {
  description = "Private IP address for the application tier load balancer frontend"
  type        = string
  default     = null
}

variable "app_lb_private_ip_address_allocation" {
  description = "Private IP address allocation method for the application tier load balancer"
  type        = string
  default     = "Dynamic"

  validation {
    condition     = contains(["Static", "Dynamic"], var.app_lb_private_ip_address_allocation)
    error_message = "Application load balancer private IP address allocation must be either 'Static' or 'Dynamic'."
  }
}

variable "app_lb_private_ip_address_version" {
  description = "Private IP address version for the application tier load balancer"
  type        = string
  default     = "IPv4"

  validation {
    condition     = contains(["IPv4", "IPv6"], var.app_lb_private_ip_address_version)
    error_message = "Application load balancer private IP address version must be either 'IPv4' or 'IPv6'."
  }
}

variable "app_lb_backend_pool_name" {
  description = "Name of the application tier load balancer backend address pool"
  type        = string
  default     = "app-lb-backend-pool"
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

# =============================================================================
# APPLICATION GATEWAY VARIABLES
# =============================================================================

variable "create_application_gateway" {
  description = "Whether to create an application gateway"
  type        = bool
  default     = false
}

variable "app_gateway_name" {
  description = "Name of the application gateway"
  type        = string
  default     = "appgw-multitier"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.app_gateway_name))
    error_message = "Application gateway name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "app_gateway_sku_name" {
  description = "SKU name of the application gateway"
  type        = string
  default     = "Standard_v2"

  validation {
    condition     = contains(["Standard", "Standard_v2", "WAF", "WAF_v2"], var.app_gateway_sku_name)
    error_message = "Application gateway SKU name must be one of: Standard, Standard_v2, WAF, WAF_v2."
  }
}

variable "app_gateway_sku_tier" {
  description = "SKU tier of the application gateway"
  type        = string
  default     = "Standard_v2"

  validation {
    condition     = contains(["Standard", "Standard_v2", "WAF", "WAF_v2"], var.app_gateway_sku_tier)
    error_message = "Application gateway SKU tier must be one of: Standard, Standard_v2, WAF, WAF_v2."
  }
}

variable "app_gateway_sku_capacity" {
  description = "SKU capacity of the application gateway"
  type        = number
  default     = 2

  validation {
    condition     = var.app_gateway_sku_capacity >= 1 && var.app_gateway_sku_capacity <= 125
    error_message = "Application gateway SKU capacity must be between 1 and 125."
  }
}

variable "app_gateway_public_ip_name" {
  description = "Name of the application gateway public IP"
  type        = string
  default     = "pip-appgw"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.app_gateway_public_ip_name))
    error_message = "Application gateway public IP name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "app_gateway_public_ip_allocation_method" {
  description = "Allocation method for the application gateway public IP"
  type        = string
  default     = "Static"

  validation {
    condition     = contains(["Static", "Dynamic"], var.app_gateway_public_ip_allocation_method)
    error_message = "Application gateway public IP allocation method must be either 'Static' or 'Dynamic'."
  }
}

variable "app_gateway_public_ip_sku" {
  description = "SKU of the application gateway public IP"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.app_gateway_public_ip_sku)
    error_message = "Application gateway public IP SKU must be either 'Basic' or 'Standard'."
  }
}

variable "app_gateway_public_ip_domain_name_label" {
  description = "Domain name label for the application gateway public IP"
  type        = string
  default     = null
}

variable "app_gateway_ip_configuration_name" {
  description = "Name of the application gateway IP configuration"
  type        = string
  default     = "appGatewayIpConfig"
}

variable "app_gateway_frontend_port_name" {
  description = "Name of the application gateway frontend port"
  type        = string
  default     = "appGatewayFrontendPort"
}

variable "app_gateway_frontend_port" {
  description = "Port number for the application gateway frontend port"
  type        = number
  default     = 80

  validation {
    condition     = var.app_gateway_frontend_port >= 1 && var.app_gateway_frontend_port <= 65535
    error_message = "Application gateway frontend port must be between 1 and 65535."
  }
}

variable "app_gateway_frontend_ip_configuration_name" {
  description = "Name of the application gateway frontend IP configuration"
  type        = string
  default     = "appGatewayFrontendIP"
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
      ip_addresses = ["10.0.1.10", "10.0.1.11"]
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
      cookie_based_affinity = "Disabled"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 20
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

variable "app_gateway_ssl_certificates" {
  description = "SSL certificates for the application gateway"
  type = list(object({
    name     = string
    data     = string
    password = string
  }))
  default = []
}

variable "app_gateway_authentication_certificates" {
  description = "Authentication certificates for the application gateway"
  type = list(object({
    name = string
    data = string
  }))
  default = []
}

variable "app_gateway_url_path_maps" {
  description = "URL path maps for the application gateway"
  type = list(object({
    name                                = string
    default_backend_address_pool_name   = optional(string)
    default_backend_http_settings_name  = optional(string)
    default_redirect_configuration_name = optional(string)
    path_rules = list(object({
      name                        = string
      paths                       = list(string)
      backend_address_pool_name   = optional(string)
      backend_http_settings_name  = optional(string)
      redirect_configuration_name = optional(string)
    }))
  }))
  default = []
}

variable "app_gateway_redirect_configurations" {
  description = "Redirect configurations for the application gateway"
  type = list(object({
    name                 = string
    redirect_type        = string
    target_listener_name = optional(string)
    target_url           = optional(string)
    include_path         = optional(bool)
    include_query_string = optional(bool)
  }))
  default = []
}

# =============================================================================
# BASTION HOST VARIABLES
# =============================================================================

variable "create_bastion_host" {
  description = "Whether to create a bastion host"
  type        = bool
  default     = false
}

variable "bastion_host_name" {
  description = "Name of the bastion host"
  type        = string
  default     = "bastion-multitier"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.bastion_host_name))
    error_message = "Bastion host name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "bastion_public_ip_name" {
  description = "Name of the bastion host public IP"
  type        = string
  default     = "pip-bastion"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.bastion_public_ip_name))
    error_message = "Bastion public IP name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

variable "bastion_public_ip_allocation_method" {
  description = "Allocation method for the bastion host public IP"
  type        = string
  default     = "Static"

  validation {
    condition     = contains(["Static", "Dynamic"], var.bastion_public_ip_allocation_method)
    error_message = "Bastion public IP allocation method must be either 'Static' or 'Dynamic'."
  }
}

variable "bastion_public_ip_sku" {
  description = "SKU of the bastion host public IP"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.bastion_public_ip_sku)
    error_message = "Bastion public IP SKU must be either 'Basic' or 'Standard'."
  }
}

variable "bastion_ip_configuration_name" {
  description = "Name of the bastion host IP configuration"
  type        = string
  default     = "bastion-ip-config"
}

variable "bastion_sku" {
  description = "SKU of the bastion host"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard"], var.bastion_sku)
    error_message = "Bastion SKU must be either 'Basic' or 'Standard'."
  }
}

# =============================================================================
# NETWORK WATCHER VARIABLES
# =============================================================================

variable "create_network_watcher" {
  description = "Whether to create a network watcher"
  type        = bool
  default     = false
}

variable "network_watcher_name" {
  description = "Name of the network watcher"
  type        = string
  default     = "NetworkWatcher_${var.location}"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.network_watcher_name))
    error_message = "Network watcher name must contain only alphanumeric characters, hyphens, and underscores."
  }
}

# =============================================================================
# DDoS PROTECTION VARIABLES
# =============================================================================

variable "enable_ddos_protection" {
  description = "Whether to enable DDoS protection on the virtual network"
  type        = bool
  default     = false
}

variable "ddos_protection_plan_id" {
  description = "ID of the DDoS protection plan"
  type        = string
  default     = null
}

# =============================================================================
# COMMON VARIABLES
# =============================================================================

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    "Environment" = "production"
    "Project"     = "multitier-architecture"
    "ManagedBy"   = "terraform"
  }
} 
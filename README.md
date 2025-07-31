# Azure Multi-Tier Architecture Terraform Module

This Terraform module creates a comprehensive Azure Multi-Tier Architecture with web, application, and database tiers, including load balancers, application gateways, and network security configurations.

## Architecture Overview

The module implements a secure, scalable multi-tier architecture with the following components:

```
Internet
    │
    ▼
┌─────────────────┐
│ Application     │ ← Public IP
│ Gateway         │
└─────────────────┘
    │
    ▼
┌─────────────────┐    ┌─────────────────┐
│ Web Tier        │    │ Web Tier        │
│ Load Balancer   │◄──►│ Subnet          │
└─────────────────┘    └─────────────────┘
    │
    ▼
┌─────────────────┐    ┌─────────────────┐
│ Application     │    │ Application     │
│ Tier Load       │◄──►│ Tier Subnet     │
│ Balancer        │    └─────────────────┘
└─────────────────┘
    │
    ▼
┌─────────────────┐    ┌─────────────────┐
│ Database Tier   │    │ Database Tier   │
│ (Direct Access) │◄──►│ Subnet          │
└─────────────────┘    └─────────────────┘
```

### Components

- **Virtual Network**: Main network with multiple subnets
- **Web Tier**: Public-facing web servers with load balancer
- **Application Tier**: Business logic servers with load balancer
- **Database Tier**: Database servers with restricted access
- **Application Gateway**: Layer 7 load balancer with SSL termination
- **Network Security Groups**: Tier-specific security rules
- **Route Tables**: Custom routing for each tier (optional)
- **Bastion Host**: Secure access to private resources (optional)
- **Network Watcher**: Network monitoring and diagnostics (optional)

## Features

- ✅ **Multi-Tier Architecture**: Web, Application, and Database tiers
- ✅ **Load Balancing**: Internal load balancers for each tier
- ✅ **Application Gateway**: Layer 7 load balancer with advanced features
- ✅ **Network Security**: Tier-specific NSG rules
- ✅ **Custom Routing**: Optional route tables for each tier
- ✅ **Secure Access**: Optional Bastion host for secure connectivity
- ✅ **Monitoring**: Optional Network Watcher for diagnostics
- ✅ **DDoS Protection**: Optional DDoS protection plan integration
- ✅ **Service Endpoints**: Azure service integration
- ✅ **Subnet Delegations**: Service-specific subnet configurations
- ✅ **Comprehensive Tagging**: Resource management and cost tracking

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| azurerm | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 3.0 |

## Inputs

### Required Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group where resources will be created | `string` | n/a | yes |
| location | Azure region where resources will be created | `string` | n/a | yes |

### Virtual Network Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| virtual_network_name | Name of the virtual network | `string` | `"vnet-multitier"` | no |
| virtual_network_address_space | Address space for the virtual network | `list(string)` | `["10.0.0.0/16"]` | no |
| enable_ddos_protection | Whether to enable DDoS protection on the virtual network | `bool` | `false` | no |
| ddos_protection_plan_id | ID of the DDoS protection plan | `string` | `null` | no |

### Subnet Variables

#### Web Tier Subnet

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| web_subnet_name | Name of the web tier subnet | `string` | `"snet-web"` | no |
| web_subnet_address_prefixes | Address prefixes for the web tier subnet | `list(string)` | `["10.0.1.0/24"]` | no |
| web_subnet_delegations | Service delegations for the web tier subnet | `list(object)` | `[]` | no |
| web_subnet_service_endpoints | Service endpoints for the web tier subnet | `list(string)` | `[]` | no |
| web_subnet_private_endpoint_network_policies_enabled | Enable or disable private endpoint network policies | `bool` | `false` | no |
| web_subnet_private_link_service_network_policies_enabled | Enable or disable private link service network policies | `bool` | `false` | no |

#### Application Tier Subnet

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_subnet_name | Name of the application tier subnet | `string` | `"snet-app"` | no |
| app_subnet_address_prefixes | Address prefixes for the application tier subnet | `list(string)` | `["10.0.2.0/24"]` | no |
| app_subnet_delegations | Service delegations for the application tier subnet | `list(object)` | `[]` | no |
| app_subnet_service_endpoints | Service endpoints for the application tier subnet | `list(string)` | `[]` | no |
| app_subnet_private_endpoint_network_policies_enabled | Enable or disable private endpoint network policies | `bool` | `false` | no |
| app_subnet_private_link_service_network_policies_enabled | Enable or disable private link service network policies | `bool` | `false` | no |

#### Database Tier Subnet

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database_subnet_name | Name of the database tier subnet | `string` | `"snet-database"` | no |
| database_subnet_address_prefixes | Address prefixes for the database tier subnet | `list(string)` | `["10.0.3.0/24"]` | no |
| database_subnet_delegations | Service delegations for the database tier subnet | `list(object)` | `[]` | no |
| database_subnet_service_endpoints | Service endpoints for the database tier subnet | `list(string)` | `[]` | no |
| database_subnet_private_endpoint_network_policies_enabled | Enable or disable private endpoint network policies | `bool` | `false` | no |
| database_subnet_private_link_service_network_policies_enabled | Enable or disable private link service network policies | `bool` | `false` | no |

#### Application Gateway Subnet

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_gateway_subnet_name | Name of the application gateway subnet | `string` | `"snet-appgateway"` | no |
| app_gateway_subnet_address_prefixes | Address prefixes for the application gateway subnet | `list(string)` | `["10.0.4.0/24"]` | no |

#### Bastion Host Subnet

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion_subnet_name | Name of the bastion host subnet | `string` | `"snet-bastion"` | no |
| bastion_subnet_address_prefixes | Address prefixes for the bastion host subnet | `list(string)` | `["10.0.5.0/24"]` | no |

### Network Security Group Variables

#### Web Tier NSG

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| web_nsg_name | Name of the web tier network security group | `string` | `"nsg-web"` | no |
| web_nsg_rules | Security rules for the web tier network security group | `list(object)` | See below | no |

Default web NSG rules:
```hcl
[
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
```

#### Application Tier NSG

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_nsg_name | Name of the application tier network security group | `string` | `"nsg-app"` | no |
| app_nsg_rules | Security rules for the application tier network security group | `list(object)` | See below | no |

Default app NSG rules:
```hcl
[
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
```

#### Database Tier NSG

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database_nsg_name | Name of the database tier network security group | `string` | `"nsg-database"` | no |
| database_nsg_rules | Security rules for the database tier network security group | `list(object)` | See below | no |

Default database NSG rules:
```hcl
[
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
```

### Load Balancer Variables

#### Web Tier Load Balancer

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_web_load_balancer | Whether to create a load balancer for the web tier | `bool` | `false` | no |
| web_lb_name | Name of the web tier load balancer | `string` | `"lb-web"` | no |
| web_lb_sku | SKU of the web tier load balancer | `string` | `"Standard"` | no |
| web_lb_sku_tier | SKU tier of the web tier load balancer | `string` | `"Regional"` | no |
| web_lb_frontend_ip_configuration_name | Name of the frontend IP configuration | `string` | `"web-lb-frontend-ip"` | no |
| web_lb_private_ip_address | Private IP address for the frontend | `string` | `null` | no |
| web_lb_private_ip_address_allocation | Private IP address allocation method | `string` | `"Dynamic"` | no |
| web_lb_private_ip_address_version | Private IP address version | `string` | `"IPv4"` | no |
| web_lb_backend_pool_name | Name of the backend address pool | `string` | `"web-lb-backend-pool"` | no |
| web_lb_probes | Health probes for the load balancer | `map(object)` | See below | no |
| web_lb_rules | Load balancing rules | `map(object)` | See below | no |

#### Application Tier Load Balancer

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_app_load_balancer | Whether to create a load balancer for the application tier | `bool` | `false` | no |
| app_lb_name | Name of the application tier load balancer | `string` | `"lb-app"` | no |
| app_lb_sku | SKU of the application tier load balancer | `string` | `"Standard"` | no |
| app_lb_sku_tier | SKU tier of the application tier load balancer | `string` | `"Regional"` | no |
| app_lb_frontend_ip_configuration_name | Name of the frontend IP configuration | `string` | `"app-lb-frontend-ip"` | no |
| app_lb_private_ip_address | Private IP address for the frontend | `string` | `null` | no |
| app_lb_private_ip_address_allocation | Private IP address allocation method | `string` | `"Dynamic"` | no |
| app_lb_private_ip_address_version | Private IP address version | `string` | `"IPv4"` | no |
| app_lb_backend_pool_name | Name of the backend address pool | `string` | `"app-lb-backend-pool"` | no |
| app_lb_probes | Health probes for the load balancer | `map(object)` | See below | no |
| app_lb_rules | Load balancing rules | `map(object)` | See below | no |

### Application Gateway Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_application_gateway | Whether to create an application gateway | `bool` | `false` | no |
| app_gateway_name | Name of the application gateway | `string` | `"appgw-multitier"` | no |
| app_gateway_sku_name | SKU name of the application gateway | `string` | `"Standard_v2"` | no |
| app_gateway_sku_tier | SKU tier of the application gateway | `string` | `"Standard_v2"` | no |
| app_gateway_sku_capacity | SKU capacity of the application gateway | `number` | `2` | no |
| app_gateway_public_ip_name | Name of the application gateway public IP | `string` | `"pip-appgw"` | no |
| app_gateway_public_ip_allocation_method | Allocation method for the public IP | `string` | `"Static"` | no |
| app_gateway_public_ip_sku | SKU of the public IP | `string` | `"Standard"` | no |
| app_gateway_public_ip_domain_name_label | Domain name label for the public IP | `string` | `null` | no |
| app_gateway_ip_configuration_name | Name of the IP configuration | `string` | `"appGatewayIpConfig"` | no |
| app_gateway_frontend_port_name | Name of the frontend port | `string` | `"appGatewayFrontendPort"` | no |
| app_gateway_frontend_port | Port number for the frontend port | `number` | `80` | no |
| app_gateway_frontend_ip_configuration_name | Name of the frontend IP configuration | `string` | `"appGatewayFrontendIP"` | no |
| app_gateway_backend_address_pools | Backend address pools | `list(object)` | See below | no |
| app_gateway_backend_http_settings | Backend HTTP settings | `list(object)` | See below | no |
| app_gateway_http_listeners | HTTP listeners | `list(object)` | See below | no |
| app_gateway_request_routing_rules | Request routing rules | `list(object)` | See below | no |
| app_gateway_probes | Health probes | `list(object)` | See below | no |
| app_gateway_ssl_certificates | SSL certificates | `list(object)` | `[]` | no |
| app_gateway_authentication_certificates | Authentication certificates | `list(object)` | `[]` | no |
| app_gateway_url_path_maps | URL path maps | `list(object)` | `[]` | no |
| app_gateway_redirect_configurations | Redirect configurations | `list(object)` | `[]` | no |

### Bastion Host Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_bastion_host | Whether to create a bastion host | `bool` | `false` | no |
| bastion_host_name | Name of the bastion host | `string` | `"bastion-multitier"` | no |
| bastion_public_ip_name | Name of the bastion host public IP | `string` | `"pip-bastion"` | no |
| bastion_public_ip_allocation_method | Allocation method for the public IP | `string` | `"Static"` | no |
| bastion_public_ip_sku | SKU of the public IP | `string` | `"Standard"` | no |
| bastion_ip_configuration_name | Name of the IP configuration | `string` | `"bastion-ip-config"` | no |
| bastion_sku | SKU of the bastion host | `string` | `"Standard"` | no |

### Route Table Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_web_route_table | Whether to create a route table for the web tier | `bool` | `false` | no |
| web_route_table_name | Name of the web tier route table | `string` | `"rt-web"` | no |
| web_route_table_routes | Routes for the web tier route table | `list(object)` | `[]` | no |
| web_route_table_disable_bgp_route_propagation | Disable BGP route propagation | `bool` | `false` | no |
| create_app_route_table | Whether to create a route table for the application tier | `bool` | `false` | no |
| app_route_table_name | Name of the application tier route table | `string` | `"rt-app"` | no |
| app_route_table_routes | Routes for the application tier route table | `list(object)` | `[]` | no |
| app_route_table_disable_bgp_route_propagation | Disable BGP route propagation | `bool` | `false` | no |
| create_database_route_table | Whether to create a route table for the database tier | `bool` | `false` | no |
| database_route_table_name | Name of the database tier route table | `string` | `"rt-database"` | no |
| database_route_table_routes | Routes for the database tier route table | `list(object)` | `[]` | no |
| database_route_table_disable_bgp_route_propagation | Disable BGP route propagation | `bool` | `false` | no |

### Network Watcher Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_network_watcher | Whether to create a network watcher | `bool` | `false` | no |
| network_watcher_name | Name of the network watcher | `string` | `"NetworkWatcher_${var.location}"` | no |

### Common Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| common_tags | Common tags to apply to all resources | `map(string)` | See below | no |

Default common tags:
```hcl
{
  "Environment" = "production"
  "Project"     = "multitier-architecture"
  "ManagedBy"   = "terraform"
}
```

## Outputs

### Virtual Network Outputs

| Name | Description |
|------|-------------|
| virtual_network_id | ID of the virtual network |
| virtual_network_name | Name of the virtual network |
| virtual_network_address_space | Address space of the virtual network |

### Subnet Outputs

| Name | Description |
|------|-------------|
| web_subnet_id | ID of the web tier subnet |
| web_subnet_name | Name of the web tier subnet |
| web_subnet_address_prefixes | Address prefixes of the web tier subnet |
| app_subnet_id | ID of the application tier subnet |
| app_subnet_name | Name of the application tier subnet |
| app_subnet_address_prefixes | Address prefixes of the application tier subnet |
| database_subnet_id | ID of the database tier subnet |
| database_subnet_name | Name of the database tier subnet |
| database_subnet_address_prefixes | Address prefixes of the database tier subnet |
| app_gateway_subnet_id | ID of the application gateway subnet |
| app_gateway_subnet_name | Name of the application gateway subnet |
| app_gateway_subnet_address_prefixes | Address prefixes of the application gateway subnet |
| bastion_subnet_id | ID of the bastion host subnet |
| bastion_subnet_name | Name of the bastion host subnet |
| bastion_subnet_address_prefixes | Address prefixes of the bastion host subnet |

### Network Security Group Outputs

| Name | Description |
|------|-------------|
| web_nsg_id | ID of the web tier network security group |
| web_nsg_name | Name of the web tier network security group |
| app_nsg_id | ID of the application tier network security group |
| app_nsg_name | Name of the application tier network security group |
| database_nsg_id | ID of the database tier network security group |
| database_nsg_name | Name of the database tier network security group |

### Load Balancer Outputs

| Name | Description |
|------|-------------|
| web_lb_id | ID of the web tier load balancer |
| web_lb_name | Name of the web tier load balancer |
| web_lb_frontend_ip_configuration | Frontend IP configuration of the web tier load balancer |
| web_lb_backend_pool_id | ID of the web tier load balancer backend address pool |
| web_lb_backend_pool_name | Name of the web tier load balancer backend address pool |
| app_lb_id | ID of the application tier load balancer |
| app_lb_name | Name of the application tier load balancer |
| app_lb_frontend_ip_configuration | Frontend IP configuration of the application tier load balancer |
| app_lb_backend_pool_id | ID of the application tier load balancer backend address pool |
| app_lb_backend_pool_name | Name of the application tier load balancer backend address pool |

### Application Gateway Outputs

| Name | Description |
|------|-------------|
| app_gateway_id | ID of the application gateway |
| app_gateway_name | Name of the application gateway |
| app_gateway_public_ip_id | ID of the application gateway public IP |
| app_gateway_public_ip_address | Public IP address of the application gateway |
| app_gateway_public_ip_fqdn | FQDN of the application gateway public IP |
| app_gateway_backend_address_pools | Backend address pools of the application gateway |
| app_gateway_backend_http_settings | Backend HTTP settings of the application gateway |
| app_gateway_http_listeners | HTTP listeners of the application gateway |
| app_gateway_request_routing_rules | Request routing rules of the application gateway |

### Bastion Host Outputs

| Name | Description |
|------|-------------|
| bastion_host_id | ID of the bastion host |
| bastion_host_name | Name of the bastion host |
| bastion_host_public_ip_id | ID of the bastion host public IP |
| bastion_host_public_ip_address | Public IP address of the bastion host |
| bastion_host_public_ip_fqdn | FQDN of the bastion host public IP |

### Route Table Outputs

| Name | Description |
|------|-------------|
| web_route_table_id | ID of the web tier route table |
| web_route_table_name | Name of the web tier route table |
| app_route_table_id | ID of the application tier route table |
| app_route_table_name | Name of the application tier route table |
| database_route_table_id | ID of the database tier route table |
| database_route_table_name | Name of the database tier route table |

### Network Watcher Outputs

| Name | Description |
|------|-------------|
| network_watcher_id | ID of the network watcher |
| network_watcher_name | Name of the network watcher |

### Association Outputs

| Name | Description |
|------|-------------|
| web_subnet_nsg_association_id | ID of the web subnet NSG association |
| app_subnet_nsg_association_id | ID of the application subnet NSG association |
| database_subnet_nsg_association_id | ID of the database subnet NSG association |
| web_subnet_route_table_association_id | ID of the web subnet route table association |
| app_subnet_route_table_association_id | ID of the application subnet route table association |
| database_subnet_route_table_association_id | ID of the database subnet route table association |

### Module Summary Output

| Name | Description |
|------|-------------|
| module_summary | Summary of the multi-tier architecture module deployment |

## Usage Examples

### Basic Multi-Tier Architecture

```hcl
module "multitier" {
  source = "./tfm-azure-multitier"

  resource_group_name = "rg-multitier-prod"
  location            = "eastus"

  # Enable load balancers
  create_web_load_balancer = true
  create_app_load_balancer = true

  # Enable application gateway
  create_application_gateway = true

  # Enable bastion host for secure access
  create_bastion_host = true

  # Enable network watcher
  create_network_watcher = true

  # Custom tags
  common_tags = {
    Environment = "production"
    Project     = "ecommerce-platform"
    Owner       = "devops-team"
  }
}
```

### Advanced Configuration with Custom NSG Rules

```hcl
module "multitier" {
  source = "./tfm-azure-multitier"

  resource_group_name = "rg-multitier-prod"
  location            = "eastus"

  # Custom virtual network configuration
  virtual_network_name        = "vnet-ecommerce"
  virtual_network_address_space = ["172.16.0.0/16"]

  # Custom subnet configurations
  web_subnet_address_prefixes      = ["172.16.1.0/24"]
  app_subnet_address_prefixes      = ["172.16.2.0/24"]
  database_subnet_address_prefixes = ["172.16.3.0/24"]

  # Custom NSG rules for web tier
  web_nsg_rules = [
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
      source_address_prefix      = "10.0.0.0/8"
      destination_address_prefix = "*"
      description                = "Allow SSH from internal networks"
    }
  ]

  # Custom NSG rules for application tier
  app_nsg_rules = [
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
    }
  ]

  # Custom NSG rules for database tier
  database_nsg_rules = [
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

  # Enable all components
  create_web_load_balancer     = true
  create_app_load_balancer     = true
  create_application_gateway   = true
  create_bastion_host          = true
  create_network_watcher       = true
  create_web_route_table       = true
  create_app_route_table       = true
  create_database_route_table  = true

  # Custom tags
  common_tags = {
    Environment = "production"
    Project     = "ecommerce-platform"
    Owner       = "devops-team"
    CostCenter  = "IT-001"
  }
}
```

### Application Gateway with SSL Certificate

```hcl
module "multitier" {
  source = "./tfm-azure-multitier"

  resource_group_name = "rg-multitier-prod"
  location            = "eastus"

  # Enable application gateway with SSL
  create_application_gateway = true

  # Custom application gateway configuration
  app_gateway_sku_name = "WAF_v2"
  app_gateway_sku_tier = "WAF_v2"
  app_gateway_sku_capacity = 2

  # SSL certificate configuration
  app_gateway_ssl_certificates = [
    {
      name     = "ssl-cert"
      data     = filebase64("path/to/certificate.pfx")
      password = "certificate-password"
    }
  ]

  # HTTPS listener configuration
  app_gateway_http_listeners = [
    {
      name                 = "https-listener"
      protocol             = "Https"
      ssl_certificate_name = "ssl-cert"
    }
  ]

  # Backend configuration
  app_gateway_backend_address_pools = [
    {
      name = "web-backend-pool"
      ip_addresses = ["172.16.1.10", "172.16.1.11"]
    }
  ]

  app_gateway_backend_http_settings = [
    {
      name                  = "web-http-settings"
      cookie_based_affinity = "Enabled"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 30
    }
  ]

  app_gateway_request_routing_rules = [
    {
      name                       = "https-routing-rule"
      rule_type                  = "Basic"
      http_listener_name         = "https-listener"
      backend_address_pool_name  = "web-backend-pool"
      backend_http_settings_name = "web-http-settings"
    }
  ]

  # Custom tags
  common_tags = {
    Environment = "production"
    Project     = "secure-web-app"
    Owner       = "security-team"
  }
}
```

## Best Practices

### Security

1. **Network Security Groups**: Always configure appropriate NSG rules for each tier
2. **Private Subnets**: Use private subnets for application and database tiers
3. **Bastion Host**: Enable bastion host for secure access to private resources
4. **DDoS Protection**: Enable DDoS protection for production workloads
5. **Service Endpoints**: Use service endpoints for Azure service integration

### Performance

1. **Load Balancer SKU**: Use Standard SKU for production workloads
2. **Application Gateway**: Use WAF_v2 SKU for web application firewall capabilities
3. **Route Tables**: Use custom route tables for complex routing scenarios
4. **Network Watcher**: Enable network watcher for monitoring and diagnostics

### Cost Optimization

1. **Resource Naming**: Use consistent naming conventions for cost tracking
2. **Tags**: Apply comprehensive tags for resource management
3. **SKU Selection**: Choose appropriate SKUs based on workload requirements
4. **Capacity Planning**: Right-size application gateway capacity

### Monitoring and Maintenance

1. **Health Probes**: Configure appropriate health probes for load balancers
2. **Logging**: Enable diagnostic logging for network resources
3. **Backup**: Implement backup strategies for critical configurations
4. **Updates**: Keep Terraform and provider versions updated

## Troubleshooting

### Common Issues

1. **Subnet Address Conflicts**: Ensure subnet address ranges don't overlap
2. **NSG Rule Conflicts**: Check for conflicting NSG rules
3. **Load Balancer Health**: Verify health probe configurations
4. **Application Gateway**: Check SSL certificate configurations

### Validation

```bash
# Validate Terraform configuration
terraform validate

# Format Terraform code
terraform fmt

# Plan deployment
terraform plan

# Apply configuration
terraform apply
```

### Network Connectivity Testing

```bash
# Test connectivity to web tier
curl -I http://<web-lb-ip>

# Test connectivity to application tier
curl -I http://<app-lb-ip>:8080

# Test database connectivity (from application tier)
telnet <database-ip> 1433
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This module is licensed under the MIT License. See the LICENSE file for details.

## Support

For support and questions:

- Create an issue in the repository
- Contact the development team
- Review the Azure documentation for specific resource configurations

## Changelog

### Version 1.0.0
- Initial release
- Multi-tier architecture support
- Load balancer integration
- Application gateway support
- Network security group configuration
- Bastion host integration
- Comprehensive documentation and examples
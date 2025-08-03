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
- 📋 **Resource Map**: Comprehensive documentation of all created resources

## Documentation

- [**Resource Map**](RESOURCE_MAP.md) - Detailed overview of all Azure resources, their relationships, and dependencies
- [**Examples**](examples/) - Working examples for different deployment scenarios
- [**Tests**](tests/) - Comprehensive test suite for module validation
- [**Contributing**](CONTRIBUTING.md) - Guidelines for contributing to the module
- [**Changelog**](CHANGELOG.md) - Version history and changes

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.13.0 |
| azurerm | ~> 4.38.1 |

## Providers

| Name | Version |
|------|---------|
| azurerm | ~> 4.38.1 |

## Inputs

### Required Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Name of the resource group where resources will be created (string) | `string` | n/a | yes |
| location | Azure region where resources will be created (string) | `string` | n/a | yes |

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

#### Application Tier Subnet

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_subnet_name | Name of the application tier subnet | `string` | `"snet-app"` | no |
| app_subnet_address_prefixes | Address prefixes for the application tier subnet | `list(string)` | `["10.0.2.0/24"]` | no |
| app_subnet_delegations | Service delegations for the application tier subnet | `list(object)` | `[]` | no |
| app_subnet_service_endpoints | Service endpoints for the application tier subnet | `list(string)` | `[]` | no |

#### Database Tier Subnet

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database_subnet_name | Name of the database tier subnet | `string` | `"snet-database"` | no |
| database_subnet_address_prefixes | Address prefixes for the database tier subnet | `list(string)` | `["10.0.3.0/24"]` | no |
| database_subnet_delegations | Service delegations for the database tier subnet | `list(object)` | `[]` | no |
| database_subnet_service_endpoints | Service endpoints for the database tier subnet | `list(string)` | `[]` | no |

### Network Security Group Variables

#### Web Tier NSG

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| web_nsg_name | Name of the web tier network security group | `string` | `"nsg-web"` | no |
| web_nsg_rules | List of NSG rules for the web tier | `list(object)` | See below | no |

#### Application Tier NSG

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| app_nsg_name | Name of the application tier network security group | `string` | `"nsg-app"` | no |
| app_nsg_rules | List of NSG rules for the application tier | `list(object)` | See below | no |

#### Database Tier NSG

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| database_nsg_name | Name of the database tier network security group | `string` | `"nsg-database"` | no |
| database_nsg_rules | List of NSG rules for the database tier | `list(object)` | See below | no |

### Load Balancer Variables

#### Web Tier Load Balancer

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_web_load_balancer | Whether to create the web tier load balancer | `bool` | `true` | no |
| web_lb_name | Name of the web tier load balancer | `string` | `"lb-web"` | no |
| web_lb_sku | SKU of the web tier load balancer | `string` | `"Standard"` | no |
| web_lb_sku_tier | SKU tier of the web tier load balancer | `string` | `"Regional"` | no |

#### Application Tier Load Balancer

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_app_load_balancer | Whether to create the application tier load balancer | `bool` | `true` | no |
| app_lb_name | Name of the application tier load balancer | `string` | `"lb-app"` | no |
| app_lb_sku | SKU of the application tier load balancer | `string` | `"Standard"` | no |
| app_lb_sku_tier | SKU tier of the application tier load balancer | `string` | `"Regional"` | no |

### Application Gateway Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_application_gateway | Whether to create the application gateway | `bool` | `true` | no |
| app_gateway_name | Name of the application gateway | `string` | `"agw-multitier"` | no |
| app_gateway_sku_name | SKU name of the application gateway | `string` | `"Standard_v2"` | no |
| app_gateway_sku_tier | SKU tier of the application gateway | `string` | `"Standard_v2"` | no |
| app_gateway_sku_capacity | Capacity of the application gateway | `number` | `2` | no |

### Bastion Host Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_bastion_host | Whether to create the bastion host | `bool` | `false` | no |
| bastion_host_name | Name of the bastion host | `string` | `"bastion-multitier"` | no |
| bastion_sku | SKU of the bastion host | `string` | `"Standard"` | no |

### Network Watcher Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create_network_watcher | Whether to create a network watcher | `bool` | `false` | no |
| network_watcher_name | Name of the network watcher | `string` | `null` | no |

### Common Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| common_tags | Common tags to be applied to all resources | `map(string)` | `{}` | no |

## Outputs

### Virtual Network Outputs

| Name | Description |
|------|-------------|
| virtual_network_id | The ID of the virtual network |
| virtual_network_name | The name of the virtual network |
| virtual_network_address_space | The address space of the virtual network |

### Subnet Outputs

| Name | Description |
|------|-------------|
| web_subnet_id | The ID of the web tier subnet |
| web_subnet_name | The name of the web tier subnet |
| web_subnet_address_prefixes | The address prefixes of the web tier subnet |
| app_subnet_id | The ID of the application tier subnet |
| app_subnet_name | The name of the application tier subnet |
| app_subnet_address_prefixes | The address prefixes of the application tier subnet |
| database_subnet_id | The ID of the database tier subnet |
| database_subnet_name | The name of the database tier subnet |
| database_subnet_address_prefixes | The address prefixes of the database tier subnet |

### Network Security Group Outputs

| Name | Description |
|------|-------------|
| web_nsg_id | The ID of the web tier network security group |
| web_nsg_name | The name of the web tier network security group |
| app_nsg_id | The ID of the application tier network security group |
| app_nsg_name | The name of the application tier network security group |
| database_nsg_id | The ID of the database tier network security group |
| database_nsg_name | The name of the database tier network security group |

### Load Balancer Outputs

| Name | Description |
|------|-------------|
| web_lb_id | The ID of the web tier load balancer |
| web_lb_name | The name of the web tier load balancer |
| web_lb_frontend_ip_configuration | The frontend IP configuration of the web tier load balancer |
| web_lb_backend_pool_id | The ID of the web tier load balancer backend pool |
| web_lb_backend_pool_name | The name of the web tier load balancer backend pool |
| app_lb_id | The ID of the application tier load balancer |
| app_lb_name | The name of the application tier load balancer |
| app_lb_frontend_ip_configuration | The frontend IP configuration of the application tier load balancer |
| app_lb_backend_pool_id | The ID of the application tier load balancer backend pool |
| app_lb_backend_pool_name | The name of the application tier load balancer backend pool |

### Application Gateway Outputs

| Name | Description |
|------|-------------|
| app_gateway_id | The ID of the application gateway |
| app_gateway_name | The name of the application gateway |
| app_gateway_public_ip_id | The ID of the application gateway public IP |
| app_gateway_public_ip_address | The public IP address of the application gateway |
| app_gateway_public_ip_fqdn | The FQDN of the application gateway public IP |

### Bastion Host Outputs

| Name | Description |
|------|-------------|
| bastion_host_id | The ID of the bastion host |
| bastion_host_name | The name of the bastion host |
| bastion_host_public_ip_id | The ID of the bastion host public IP |
| bastion_host_public_ip_address | The public IP address of the bastion host |
| bastion_host_public_ip_fqdn | The FQDN of the bastion host public IP |

### Network Watcher Outputs

| Name | Description |
|------|-------------|
| network_watcher_id | The ID of the network watcher |
| network_watcher_name | The name of the network watcher |

## Usage

### Basic Usage

```hcl
module "multitier" {
  source = "github.com/your-username/tfm-azure-multitier"

  resource_group_name = "my-resource-group"
  location           = "eastus"

  # Optional: Custom address spaces
  virtual_network_address_space = ["10.0.0.0/16"]
  web_subnet_address_prefixes   = ["10.0.1.0/24"]
  app_subnet_address_prefixes   = ["10.0.2.0/24"]
  database_subnet_address_prefixes = ["10.0.3.0/24"]

  # Optional: Enable bastion host
  create_bastion_host = true

  # Optional: Enable network watcher
  create_network_watcher = true

  # Optional: Custom tags
  common_tags = {
    Environment = "production"
    Project     = "my-project"
    Owner       = "my-team"
  }
}
```

### Advanced Usage with Custom NSG Rules

```hcl
module "multitier" {
  source = "github.com/your-username/tfm-azure-multitier"

  resource_group_name = "my-resource-group"
  location           = "eastus"

  # Custom NSG rules for web tier
  web_nsg_rules = [
    {
      name                       = "allow-http"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-https"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  # Custom NSG rules for application tier
  app_nsg_rules = [
    {
      name                       = "allow-web-tier"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "10.0.1.0/24"
      destination_address_prefix = "*"
    }
  ]

  # Custom NSG rules for database tier
  database_nsg_rules = [
    {
      name                       = "allow-app-tier"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "1433"
      source_address_prefix      = "10.0.2.0/24"
      destination_address_prefix = "*"
    }
  ]
}
```

## Examples

See the [examples](./examples) directory for complete working examples:

- [Basic Example](./examples/basic) - Minimal configuration
- [Advanced Example](./examples/advanced) - Full configuration with all features

## Testing

This module includes a comprehensive testing framework using Terraform's native testing capabilities.

### Running Tests

```bash
# Run all tests
terraform test

# Run specific test file
terraform test tests/basic.tftest.hcl

# Run with verbose output
terraform test -verbose
```

### Test Coverage

- **Basic Deployment**: Validates default configuration and resource creation
- **Custom Configuration**: Tests custom address spaces and configurations
- **Validation**: Ensures proper error handling and input validation
- **Integration**: End-to-end deployment testing (planned)

See [tests/README.md](tests/README.md) for detailed testing documentation.

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

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for detailed contribution guidelines.

## License

This module is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Support

For support and questions:

- Create an issue in the repository
- Contact the development team
- Review the Azure documentation for specific resource configurations

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed history of changes.

### Version 1.0.0
- Initial release
- Multi-tier architecture support
- Load balancer integration
- Application gateway support
- Network security group configuration
- Bastion host integration
- Comprehensive documentation and examples
- Testing framework implementation
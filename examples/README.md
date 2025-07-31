# Azure Multi-Tier Architecture Module Examples

This directory contains practical examples demonstrating how to use the Azure Multi-Tier Architecture Terraform module.

## Examples Overview

### Basic Example (`basic/`)
A minimal multi-tier architecture setup with essential components:
- Virtual network with three tiers (web, application, database)
- Network security groups with basic rules
- Optional load balancers for web and application tiers
- Optional application gateway
- Optional bastion host and network watcher

### Advanced Example (`advanced/`)
A comprehensive multi-tier architecture with all features enabled:
- Complete virtual network setup with service endpoints
- Advanced network security group configurations
- Load balancers with health probes and rules
- Application gateway with WAF capabilities
- Bastion host for secure access
- Network watcher for monitoring
- Custom route tables (optional)
- DDoS protection (optional)

## Prerequisites

Before running these examples, ensure you have:

1. **Azure CLI** installed and configured
2. **Terraform** (version >= 1.0) installed
3. **Azure Subscription** with appropriate permissions
4. **Resource Group** (or create one as part of the example)

## Quick Start

### 1. Basic Example

```bash
# Navigate to the basic example directory
cd examples/basic

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

### 2. Advanced Example

```bash
# Navigate to the advanced example directory
cd examples/advanced

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Apply the configuration
terraform apply
```

## Configuration Examples

### Basic Configuration

The basic example creates a simple multi-tier architecture:

```hcl
module "multitier" {
  source = "../../"

  resource_group_name = "rg-multitier-basic"
  location            = "eastus"

  # Enable load balancers
  create_web_load_balancer = true
  create_app_load_balancer = true

  # Optional components
  create_application_gateway = false
  create_bastion_host        = false
  create_network_watcher     = false
}
```

### Advanced Configuration

The advanced example demonstrates comprehensive features:

```hcl
module "multitier" {
  source = "../../"

  resource_group_name = "rg-multitier-advanced"
  location            = "eastus"

  # Custom network configuration
  virtual_network_address_space = ["172.16.0.0/16"]
  web_subnet_address_prefixes   = ["172.16.1.0/24"]
  app_subnet_address_prefixes   = ["172.16.2.0/24"]
  database_subnet_address_prefixes = ["172.16.3.0/24"]

  # Service endpoints
  web_subnet_service_endpoints      = ["Microsoft.Storage", "Microsoft.KeyVault"]
  app_subnet_service_endpoints      = ["Microsoft.Storage", "Microsoft.KeyVault", "Microsoft.ServiceBus"]
  database_subnet_service_endpoints = ["Microsoft.Sql", "Microsoft.KeyVault"]

  # Custom NSG rules
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
    }
  ]

  # Enable all components
  create_web_load_balancer     = true
  create_app_load_balancer     = true
  create_application_gateway   = true
  create_bastion_host          = true
  create_network_watcher       = true
}
```

## Customization

### Modifying Network Addresses

To use different network addresses:

```hcl
variable "virtual_network_address_space" {
  default = ["192.168.0.0/16"]
}

variable "web_subnet_address_prefixes" {
  default = ["192.168.1.0/24"]
}

variable "app_subnet_address_prefixes" {
  default = ["192.168.2.0/24"]
}

variable "database_subnet_address_prefixes" {
  default = ["192.168.3.0/24"]
}
```

### Custom NSG Rules

To add custom security rules:

```hcl
variable "web_nsg_rules" {
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
    },
    {
      name                       = "AllowCustomPort"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "8080"
      source_address_prefix      = "10.0.0.0/8"
      destination_address_prefix = "*"
    }
  ]
}
```

### Load Balancer Configuration

To customize load balancer settings:

```hcl
variable "web_lb_probes" {
  default = {
    "web-http-probe" = {
      name                = "web-http-probe"
      port                = 80
      protocol            = "Http"
      request_path        = "/health"
      interval_in_seconds = 30
      number_of_probes    = 3
    }
  }
}

variable "web_lb_rules" {
  default = {
    "web-http-rule" = {
      name                    = "web-http-rule"
      probe_name              = "web-http-probe"
      protocol                = "Tcp"
      frontend_port           = 80
      backend_port            = 80
      load_distribution       = "SourceIP"
      enable_floating_ip      = true
      idle_timeout_in_minutes = 10
    }
  }
}
```

## Security Considerations

### Network Security Groups

- **Web Tier**: Allow HTTP/HTTPS from internet, SSH from bastion
- **Application Tier**: Allow traffic from web tier, internal communication
- **Database Tier**: Allow traffic only from application tier and bastion

### Bastion Host

- Always use bastion host for secure access to private resources
- Configure NSG rules to allow SSH access only from bastion subnet
- Use strong authentication methods

### Application Gateway

- Enable WAF for web application firewall capabilities
- Configure SSL certificates for HTTPS traffic
- Use health probes to ensure backend availability

## Cost Optimization

### Resource SKUs

- Use Standard SKU for production workloads
- Choose appropriate capacity for application gateway
- Consider Basic SKU for development environments

### Monitoring

- Enable network watcher for diagnostics
- Use Azure Monitor for performance monitoring
- Set up alerts for cost thresholds

## Troubleshooting

### Common Issues

1. **Subnet Address Conflicts**
   - Ensure subnet ranges don't overlap
   - Check for conflicts with existing networks

2. **NSG Rule Conflicts**
   - Verify rule priorities
   - Check for conflicting allow/deny rules

3. **Load Balancer Health**
   - Verify health probe configurations
   - Check backend server availability

4. **Application Gateway Issues**
   - Validate SSL certificate configurations
   - Check backend pool configurations

### Validation Commands

```bash
# Validate Terraform configuration
terraform validate

# Format code
terraform fmt

# Check plan
terraform plan -var-file="terraform.tfvars"

# Apply with specific variables
terraform apply -var="location=westus2"
```

## Cleanup

To destroy the infrastructure:

```bash
# Destroy all resources
terraform destroy

# Destroy with specific variables
terraform destroy -var-file="terraform.tfvars"
```

## Next Steps

After deploying the multi-tier architecture:

1. **Deploy Virtual Machines**: Add compute resources to each tier
2. **Configure Applications**: Deploy web and application servers
3. **Set Up Database**: Configure database servers or managed services
4. **Implement Monitoring**: Set up Azure Monitor and alerts
5. **Configure Backup**: Implement backup strategies
6. **Security Hardening**: Apply additional security measures

## Support

For issues and questions:

- Check the main module documentation
- Review Azure documentation for specific resources
- Create an issue in the repository
- Contact the development team

## Contributing

To contribute examples:

1. Create a new directory under `examples/`
2. Include `main.tf`, `variables.tf`, and `README.md`
3. Follow the existing naming conventions
4. Test the example thoroughly
5. Submit a pull request 
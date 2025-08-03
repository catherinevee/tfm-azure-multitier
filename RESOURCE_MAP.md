# Azure Multi-Tier Architecture Module - Resource Map

This document provides a comprehensive overview of all Azure resources created by the `tfm-azure-multitier` Terraform module, their relationships, and dependencies.

## Resource Overview

The module creates a complete Azure multi-tier architecture with the following resource types:

| Resource Type | Azure Resource | Purpose | Conditional |
|---------------|----------------|---------|-------------|
| **Core Infrastructure** | | | |
| `azurerm_virtual_network` | Virtual Network | Main network with multiple subnets | Always |
| `azurerm_subnet` | Subnets | Tier-specific network segments | Always (Web, App, DB) |
| `azurerm_subnet` | Application Gateway Subnet | Dedicated subnet for Application Gateway | Optional |
| `azurerm_subnet` | Bastion Subnet | Dedicated subnet for Bastion Host | Optional |
| **Security** | | | |
| `azurerm_network_security_group` | Network Security Groups | Tier-specific security rules | Always (Web, App, DB) |
| `azurerm_subnet_network_security_group_association` | NSG Associations | Link NSGs to subnets | Always |
| **Load Balancing** | | | |
| `azurerm_lb` | Load Balancers | Internal load balancing for tiers | Optional (Web, App) |
| `azurerm_lb_backend_address_pool` | Backend Pools | Target resources for load balancers | Optional |
| `azurerm_lb_probe` | Health Probes | Health monitoring for load balancers | Optional |
| `azurerm_lb_rule` | Load Balancer Rules | Traffic distribution rules | Optional |
| **Application Gateway** | | | |
| `azurerm_public_ip` | Application Gateway Public IP | Public endpoint for Application Gateway | Optional |
| `azurerm_application_gateway` | Application Gateway | Layer 7 load balancer with advanced features | Optional |
| **Secure Access** | | | |
| `azurerm_public_ip` | Bastion Public IP | Public endpoint for Bastion Host | Optional |
| `azurerm_bastion_host` | Bastion Host | Secure access to private resources | Optional |
| **Routing** | | | |
| `azurerm_route_table` | Route Tables | Custom routing for each tier | Optional |
| `azurerm_subnet_route_table_association` | Route Table Associations | Link route tables to subnets | Optional |
| **Monitoring** | | | |
| `azurerm_network_watcher` | Network Watcher | Network monitoring and diagnostics | Optional |

## Resource Dependencies

### Core Network Dependencies
```
Virtual Network
├── Web Subnet
├── Application Subnet
├── Database Subnet
├── Application Gateway Subnet (optional)
└── Bastion Subnet (optional)
```

### Security Dependencies
```
Network Security Groups
├── Web NSG → Web Subnet
├── Application NSG → Application Subnet
└── Database NSG → Database Subnet
```

### Load Balancing Dependencies
```
Load Balancers
├── Web Load Balancer
│   ├── Backend Pool
│   ├── Health Probes
│   └── Load Balancer Rules
└── Application Load Balancer
    ├── Backend Pool
    ├── Health Probes
    └── Load Balancer Rules
```

### Application Gateway Dependencies
```
Application Gateway
├── Public IP
├── Subnet (dedicated)
├── Backend Address Pools
├── Backend HTTP Settings
├── HTTP Listeners
├── Request Routing Rules
├── Probes
├── SSL Certificates (optional)
├── Authentication Certificates (optional)
├── URL Path Maps (optional)
└── Redirect Configurations (optional)
```

### Routing Dependencies
```
Route Tables
├── Web Route Table → Web Subnet
├── Application Route Table → Application Subnet
└── Database Route Table → Database Subnet
```

## Resource Configuration Details

### Virtual Network
- **Purpose**: Central network infrastructure
- **Address Space**: Configurable (default: 10.0.0.0/16)
- **DDoS Protection**: Optional integration
- **Lifecycle**: Prevent destroy enabled
- **Tags**: Comprehensive tagging strategy

### Subnets
- **Web Tier**: Public-facing resources (default: 10.0.1.0/24)
- **Application Tier**: Business logic (default: 10.0.2.0/24)
- **Database Tier**: Data storage (default: 10.0.3.0/24)
- **Application Gateway**: Dedicated subnet (default: 10.0.4.0/24)
- **Bastion**: Secure access (default: 10.0.5.0/24)

### Network Security Groups
- **Web NSG**: Allow HTTP/HTTPS inbound, restrict outbound
- **Application NSG**: Allow internal communication, restrict external
- **Database NSG**: Most restrictive, allow only necessary traffic

### Load Balancers
- **SKU**: Standard (recommended) or Basic
- **Type**: Internal (private IP)
- **Health Probes**: Configurable protocols and ports
- **Rules**: Custom traffic distribution

### Application Gateway
- **SKU**: Standard_v2, WAF_v2, or Standard
- **Tier**: Regional or Global
- **Capacity**: Configurable instance count
- **Features**: SSL termination, session affinity, URL-based routing

### Bastion Host
- **SKU**: Standard or Basic
- **Access**: RDP/SSH to private resources
- **Security**: No direct internet access required

### Route Tables
- **Purpose**: Custom routing for each tier
- **BGP Propagation**: Configurable
- **Routes**: Custom route definitions

### Network Watcher
- **Purpose**: Network monitoring and diagnostics
- **Features**: Connection monitoring, packet capture, flow logs

## Naming Conventions

All resources follow consistent naming patterns:
- **Virtual Network**: `vnet-{name}`
- **Subnets**: `snet-{tier}`
- **NSGs**: `nsg-{tier}`
- **Load Balancers**: `lb-{tier}`
- **Application Gateway**: `agw-{name}`
- **Bastion Host**: `bas-{name}`
- **Route Tables**: `rt-{tier}`
- **Public IPs**: `pip-{purpose}`

## Tagging Strategy

All resources include comprehensive tags:
- **Module**: `azure-multitier`
- **Component**: Resource type identifier
- **Tier**: Web, Application, Database, or Infrastructure
- **Environment**: From common_tags
- **Project**: From common_tags
- **Cost Center**: From common_tags

## Cost Considerations

### High-Cost Resources
1. **Application Gateway**: ~$0.50/hour for Standard_v2
2. **Bastion Host**: ~$0.19/hour for Standard
3. **Load Balancers**: ~$0.03/hour for Standard
4. **Network Watcher**: ~$0.50/month

### Cost Optimization
- Use Basic SKUs for development environments
- Disable optional components (Bastion, Network Watcher) when not needed
- Implement proper resource sizing
- Use Azure Hybrid Benefit where applicable

## Security Considerations

### Network Security
- Tier isolation through NSGs
- Private subnets for sensitive resources
- Service endpoints for Azure services
- DDoS protection integration

### Access Control
- Bastion host for secure access
- No direct internet access to private resources
- Principle of least privilege
- Comprehensive logging and monitoring

### Compliance
- Azure Security Center integration
- Network security group flow logs
- Diagnostic settings for audit trails
- Resource locks for critical resources

## Monitoring and Diagnostics

### Network Monitoring
- Network Watcher for connectivity monitoring
- NSG flow logs for traffic analysis
- Application Gateway metrics
- Load balancer health monitoring

### Diagnostic Settings
- Activity logs for all resources
- Network security group flow logs
- Application Gateway access logs
- Bastion host logs

## Backup and Recovery

### Resource Backup
- Virtual network configuration backup
- NSG rule exports
- Route table configurations
- Application Gateway configurations

### Disaster Recovery
- Cross-region deployment capability
- Resource group-level backup
- Configuration as code (Terraform state)
- Documentation for manual recovery

## Compliance and Governance

### Azure Policy Integration
- Resource naming conventions
- Tagging requirements
- Security baseline compliance
- Cost management policies

### Regulatory Compliance
- GDPR considerations for data residency
- SOC 2 compliance for security controls
- ISO 27001 alignment
- Industry-specific requirements

## Performance Optimization

### Network Performance
- Proximity placement groups for low latency
- Accelerated networking where supported
- Optimal subnet sizing
- Efficient routing configurations

### Scalability
- Auto-scaling capabilities
- Load balancer health monitoring
- Application Gateway scaling rules
- Resource group organization

## Troubleshooting Guide

### Common Issues
1. **Subnet Conflicts**: Address space overlap
2. **NSG Rule Conflicts**: Conflicting security rules
3. **Load Balancer Health Failures**: Incorrect probe configurations
4. **Application Gateway Issues**: SSL certificate problems

### Diagnostic Commands
- `az network vnet show` - Virtual network status
- `az network nsg rule list` - NSG rule verification
- `az network lb show` - Load balancer health
- `az network application-gateway show` - Application Gateway status

## Best Practices

### Design Principles
- Defense in depth
- Zero trust architecture
- Least privilege access
- Comprehensive monitoring

### Implementation Guidelines
- Use consistent naming conventions
- Implement proper tagging strategy
- Follow Azure Well-Architected Framework
- Regular security reviews and updates

### Maintenance
- Regular Terraform plan/apply cycles
- Security rule reviews
- Performance monitoring
- Cost optimization reviews 
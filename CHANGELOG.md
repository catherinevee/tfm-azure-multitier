# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive multi-tier architecture support
- Load balancer integration for web and application tiers
- Application Gateway with advanced features
- Network Security Groups with tier-specific rules
- Route tables for custom routing scenarios
- Bastion host for secure access
- Network Watcher for monitoring and diagnostics
- DDoS protection plan integration
- Service endpoints and subnet delegations
- Comprehensive input validation
- Extensive output variables
- Testing framework with native Terraform tests
- Complete documentation and examples

### Changed
- Updated Terraform version requirement to >= 1.13.0
- Updated Azure provider version to ~> 4.38.1
- Enhanced variable validation with comprehensive rules
- Improved resource tagging and organization
- Streamlined module structure and documentation

### Fixed
- Resolved Azure provider compatibility issues
- Fixed variable validation for network watcher name
- Corrected subnet and NSG association configurations
- Improved error handling and validation messages

## [1.0.0] - 2024-01-01

### Added
- Initial release of tfm-azure-dmz module
- Multi-tier architecture with web, application, and database tiers
- Virtual network with multiple subnets
- Network Security Groups for each tier
- Load balancers for web and application tiers
- Application Gateway with SSL termination
- Route tables for custom routing
- Bastion host for secure access
- Network Watcher for monitoring
- Comprehensive documentation and examples
- Input validation and error handling
- Resource tagging and organization

### Security
- Tier-specific network security group rules
- Private subnets for application and database tiers
- Secure bastion host access
- DDoS protection integration
- Service endpoint configurations

### Performance
- Standard SKU load balancers
- Application Gateway with WAF capabilities
- Optimized subnet configurations
- Network monitoring and diagnostics 
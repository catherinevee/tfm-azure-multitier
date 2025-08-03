# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive Resource Map documentation (`RESOURCE_MAP.md`)
- MIT License file
- Enhanced README with documentation links
- Contributing guidelines (`CONTRIBUTING.md`)

### Changed
- Updated Terraform version requirement to `>= 1.13.0`
- Updated Azure provider version to `~> 4.38.1`
- Enhanced documentation structure and organization

### Fixed
- Registry compliance issues
- Missing documentation files

## [1.0.0] - 2024-01-01

### Added
- Initial release of Azure Multi-Tier Architecture module
- Virtual Network with multiple subnets (Web, Application, Database, Application Gateway, Bastion)
- Network Security Groups for each tier with configurable rules
- Load Balancers for Web and Application tiers
- Application Gateway with advanced configuration options
- Route Tables for custom routing (optional)
- Bastion Host for secure access (optional)
- Network Watcher for monitoring and diagnostics (optional)
- DDoS Protection integration (optional)
- Service Endpoints and Subnet Delegations support
- Comprehensive tagging strategy
- Extensive variable validation and type constraints
- Complete output definitions for all resources
- Basic and advanced examples
- Basic test coverage

### Features
- Multi-tier architecture with web, application, and database tiers
- Load balancing with internal load balancers
- Layer 7 load balancing with Application Gateway
- Network security with tier-specific NSG rules
- Custom routing with optional route tables
- Secure access with optional Bastion host
- Network monitoring with optional Network Watcher
- DDoS protection integration
- Service endpoints and subnet delegations
- Comprehensive resource tagging 
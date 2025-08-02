# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive .gitignore file for Terraform projects
- MIT License file
- CHANGELOG.md for version tracking
- Enhanced variable validations with length constraints
- Lifecycle management for critical resources
- Improved output descriptions with data types
- Basic testing framework structure

### Changed
- Updated Terraform required version to >= 1.13.0
- Updated Azure provider version to ~> 4.38.1
- Enhanced variable validation blocks with better error messages
- Improved tagging strategy with default tags

### Fixed
- Provider version constraints updated to latest stable versions
- Variable validation improvements for better error handling
- Output descriptions enhanced for better documentation

## [1.0.0] - 2025-01-XX

### Added
- Initial release of Azure Multi-Tier Architecture module
- Virtual Network with multiple subnets (Web, Application, Database)
- Network Security Groups for each tier
- Load Balancers for Web and Application tiers
- Application Gateway with SSL termination
- Bastion Host for secure access
- Network Watcher for monitoring
- Route Tables for custom routing
- DDoS Protection integration
- Service Endpoints and Subnet Delegations
- Comprehensive tagging strategy

### Features
- Multi-tier architecture support
- Configurable subnet configurations
- Custom NSG rules per tier
- Load balancer health checks and rules
- Application Gateway with advanced features
- Secure access through Bastion Host
- Network monitoring and diagnostics
- Cost optimization through proper resource sizing 
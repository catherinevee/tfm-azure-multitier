# Variables for Basic Multi-Tier Architecture Example

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-multitier-basic"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-multitier-basic"
}

variable "virtual_network_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "web_subnet_address_prefixes" {
  description = "Address prefixes for the web tier subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "app_subnet_address_prefixes" {
  description = "Address prefixes for the application tier subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "database_subnet_address_prefixes" {
  description = "Address prefixes for the database tier subnet"
  type        = list(string)
  default     = ["10.0.3.0/24"]
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

variable "create_application_gateway" {
  description = "Whether to create an application gateway"
  type        = bool
  default     = false
}

variable "create_bastion_host" {
  description = "Whether to create a bastion host"
  type        = bool
  default     = false
}

variable "create_network_watcher" {
  description = "Whether to create a network watcher"
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "development"
    Project     = "multitier-basic"
    ManagedBy   = "terraform"
  }
} 